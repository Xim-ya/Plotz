import 'dart:developer';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel({
    required LoadContentDetailInfoUseCase loadContentMainDescription,
    required LoadContentCreditInfoUseCase loadContentCreditInfo,
    required UpdateUserPreferencesUserCase updateUserPreferencesUserCase,
    required UserRepository userRepository,
    required UserService userService,
    required ContentArgumentFormat argument,
    required ChannelRepository channelRepository,
    required LoadContentVideoInfoUseCase loadContentVideoInfoUseCase,
  })  : _passedArgument = argument,
        _loadContentDetailInfoUseCase = loadContentMainDescription,
        _loadContentCreditInfo = loadContentCreditInfo,
        _userRepository = userRepository,
        _userService = userService,
        _channelRepository = channelRepository,
        loadContentVideoInfo = loadContentVideoInfoUseCase,
        _updateUserPreferences = updateUserPreferencesUserCase;

  // 이전 페이지에서 전달 받는 argument
  final ContentArgumentFormat _passedArgument;

  /// Data Variables
  /// // 컨텐츠탭 정보
  ContentDetailInfo? _contentDescriptionInfo;

  // 컨텐츠 Credit 정보 리스트
  List<ContentCreditInfo>? contentCreditList;

  // 채널의 다른 콘텐츠
  List<ContentPosterShell>? channelRelatedContents;

  // 유튜브 채널
  ChannelModel? channelInfo;

  // 컨텐츠 비디오(유튜브)
  ContentVideoModel? videoInfo;

  /* [UseCase] */
  final LoadContentDetailInfoUseCase _loadContentDetailInfoUseCase;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;
  final LoadContentVideoInfoUseCase loadContentVideoInfo;
  final UpdateUserPreferencesUserCase _updateUserPreferences;

  /* Data Modules */
  final ChannelRepository _channelRepository;
  final UserRepository _userRepository;
  final UserService _userService;

  /* Bindings [For Nested Route] */
  final contentDetailBinding = ContentDetailBinding();
  final channelDetailBinding = ChannelDetailBinding();

  /********************** [SCAFFOLD RESOURCES]  **********************/
  late final TabController tabController;
  final ScrollController scrollController = ScrollController();

  /*** [State] Variables ***/

  late BehaviorSubject<double> headerImgOffsets;

  // 선택된 시즌 또는 부
  int selectedEpisode = 1;

  // 선택된 탭 인덱스
  int selectedTabIndex = 0;

  // Sliver Custom 스크롤 Offset
  double scrollOffset = 0;

  // 앱바 배경색 노출 여부
  bool hideAppBarColor = true;

  /* 메소드 */
  // 탭 바 버튼이 클릭 되었을 때
  void onTabClicked(int index) {
    selectedTabIndex = index;
  }

  // [정보] 탭이 클릭 되었을 때 1회 필요한 api call 실행
  void fetchResourcesIfNeeded() {
    if (tabController.index == 1) {
      fetchContentCreditInfo();
      tabController.removeListener(fetchResourcesIfNeeded);
    }
  }

  // 뒤로가기
  void onRouteBack(BuildContext context) {
    context.pop();
  }

  // 콘텐츠 상세 페이지로 이동
  void routeToContentDetail(ContentPosterShell content) {
    final arg = ContentArgumentFormat(
      originId: content.originId,
      contentId: content.contentId,
      contentType: content.contentType,
      videoTitle: content.videoTitle,
      title: content.title,
      posterImgUrl: content.posterImgUrl,
    );

    contentDetailBinding.isDependenciesDeleted = true;

    safeUnregister<ContentDetailViewModel>();
    safeUnregister<LoadContentDetailInfoUseCase>();
    safeUnregister<LoadContentCreditInfoUseCase>();
    safeUnregister<LoadContentVideoInfoUseCase>();
    safeUnregister<UpdateUserPreferencesUserCase>();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        final prevLocation =
            GoRouter.of(context).routeInformationProvider.value.location;
        final currentLocation = GoRouter.of(context).location;

        if (currentLocation == prevLocation &&
            contentDetailBinding.isDependenciesDeleted == true) {
          contentDetailBinding.arg1 = arg;
          contentDetailBinding.arg2 = false;
          contentDetailBinding.dependencies();
        }

        return const ContentDetailScreen();
      }),
    );
  }

  // 채널 상세 페이지로 이동
  void routeToChannelDetail() {
    safeUnregister<ChannelDetailViewModel>();
    safeUnregister<LoadPagedChannelContentsUseCase>();
    safeUnregister<UpdateUserPreferencesUserCase>();

    channelDetailBinding.isDependenciesDeleted = true;

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        final prevLocation =
            GoRouter.of(context).routeInformationProvider.value.location;
        final currentLocation = GoRouter.of(context).location;

        if (currentLocation == prevLocation &&
            channelDetailBinding.isDependenciesDeleted == true) {
          channelDetailBinding.arg1 = channelInfo;
          channelDetailBinding.arg2 = true;
          channelDetailBinding.dependencies();
        }

        return const ChannelDetailScreen();
      }),
    );
  }

  // 하단 상단 앱바 Visibility 여부를 조절하는 메소드.
  void setBackBtnVisibility() {
    if (scrollController.offset >= 430 &&
        hideAppBarColor == true &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      hideAppBarColor = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 486) {
      return;
    } else {
      if (hideAppBarColor == false &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        hideAppBarColor = true;
        notifyListeners();
      }
    }
  }

  // Scaffold ChangNotifier 초기화 구문
  void onIntentInit(TabController passedTabC) {
    headerImgOffsets = BehaviorSubject<double>.seeded(0.0);

    scrollController.addListener(() {
      setBackBtnVisibility();
      scrollOffset = scrollController.offset;
      if (scrollController.offset <= 412) {
        headerImgOffsets.add(-scrollController.offset * 0.5);
      }
    });
    tabController = passedTabC;
    tabController.addListener(fetchResourcesIfNeeded);
  }

  double get headerBgOffset => -scrollOffset * 0.5;

  /********************** [ENDS]  **********************/

  /* [Intent ] */

  // 하단 에피소드 선택 바탐 Sheet
  void showEpisodeSelectSheet() {
    showModalBottomSheet(
      context: context,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return EpisodeBottomSheet(
            onCloseBtnTapped: context.pop,
            videos: videoInfo!.videos,
            onOptionTapped: onBottomSheetOptionTapped,
            contentType: contentType);
      },
    );
  }

  // 하단 에피소드 선택 옵션이 선택 되었을 때
  void onBottomSheetOptionTapped(int index) {
    selectedEpisode = index + 1;
    notifyListeners();
    context.pop();
  }

  /// 유저 시청 기록 추가
  Future<void> addUserWatchHistory(String videoId) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value.id!,
      originId: passedArgument.originId,
    );

    final response = await _userRepository.addUserWatchHistory(requestData);
    response.fold(
      onSuccess: (_) {
        log('유저 시청기록 추가 성공');
        // 유저 시청 기록 업데이트
        _userService.updateUserWatchHistory();
      },
      onFailure: (e) {
        log('ContentDetailViewModel : $e');
      },
    );
  }

  // 콘텐츠 비디오 정보 호출
  Future<void> _fetchVideoInfo() async {
    final responseResult = await loadContentVideoInfo.call(
        contentId: passedArgument.originId,
        contentType: contentType,
        context: context);
    responseResult.fold(onSuccess: (data) {
      videoInfo = data;
      if (data.videos.length > 1) {
        selectedEpisode = data.videos[0].episodeNum;
      }

      notifyListeners();
    }, onFailure: (e) {
      AlertWidget.newToast(message: '유튜브 비디오 정보를 불러들이는데 실패했어요', context);
      log('ContentDetailViewModel ${e.toString()}');
    });
  }

  // 채널의 다른 콘텐츠 리스트 호출 (10개)
  Future<void> fetchChannelContents() async {
    final response = await _channelRepository.loadChannelContentsWithLimit(
        channelId: channelInfo!.channelId,
        currentContentId: passedArgument.originId);
    response.fold(
      onSuccess: (data) {
        channelRelatedContents = data;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '채널의 다른 콘텐츠 정보를 불러들이는 데 실패했습니다', context);
        log(e.toString());
      },
    );
  }

  // 컨텐츠 credit 정보 호출
  Future<void> fetchContentCreditInfo() async {
    final responseRes = await _loadContentCreditInfo.call(
      passedArgument.contentType,
      passedArgument.contentId,
    );

    responseRes.fold(
      onSuccess: (data) {
        contentCreditList = data;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '출연진 정보를 불러들이는 데 실패했습니다', context);
        log(e.toString());
      },
    );
  }

  // 컨텐츠 상세 정보(TMDB) 호출
  Future<void> _fetchContentMainInfo() async {
    final responseResult = await _loadContentDetailInfoUseCase.call(
      passedArgument.contentType,
      passedArgument.contentId,
    );
    responseResult.fold(
      onSuccess: (data) {
        _contentDescriptionInfo = data;
        notifyListeners();
        print('데이터 fetch 성공');
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 유튜브 채널 정보 호출
  Future<void> _fetchChannelInfo() async {
    final response =
        await _channelRepository.loadChannelById(passedArgument.originId);

    response.fold(
      onSuccess: (channel) {
        channelInfo = channel;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '채널 정보를 받아오지 못했습니다', context);
        log('ChannelDetailViewModel : $e');
      },
    );
  }

  /// Routing Method
  // 전달 받은 컨텐츠 유튜브 id 값으로 youtubeApp 실행
  Future<void> goToContent() async {
    if (videoInfo == null) {
      return AlertWidget.newToast(
          message: '잠시만 기다려주세요. 데이터를 불러오고 있습니다.', context);
    }
    final youtubeVideoId = videoInfo!.videos[selectedEpisode - 1].videoId;

    try {
      await launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=$youtubeVideoId'),
        mode: LaunchMode.externalApplication,
      );
      unawaited(
        AppAnalytics.instance.logEvent(
          name: 'playContent',
          parameters: {
            'contentDetail': _contentDescriptionInfo?.title ?? '데이터 없음'
          },
        ),
      );
    } catch (e) {
      await AlertWidget.newToast(message: '비디오 정보를 불러오지 못했습니디', context);
      throw '유튜브 앱(웹) 런치 실패';
    }

    // 시청기록 추가
    await addUserWatchHistory(youtubeVideoId);
    _updateUserPreferences.call(
      genresName: _contentDescriptionInfo?.genreList ?? [],
      channelId: channelInfo!.channelId,
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    /// NOTE 호출 순서 주의 [_fetchContentMainInfo]가
    /// 무조건 선행 되어야 함
    await _fetchContentMainInfo();
    await Future.wait([
      _fetchVideoInfo(),
      _fetchChannelInfo().whenComplete(fetchChannelContents),
    ]);
  }

  @override
  void onDispose() {
    super.onDispose();

    contentDetailBinding.unRegisterDependencies();
    channelDetailBinding.unRegisterDependencies();
  }

  /* [Getters] */
  // 컨텐츠트 타입 (영화 or tv)
  ContentType get contentType => passedArgument.contentType;

  // Argument (이전 스크린에서 전달 받은 인자)
  ContentArgumentFormat get passedArgument => _passedArgument;

  // 컨텐츠 설명
  String? get contentOverView => _contentDescriptionInfo?.overView;
}
