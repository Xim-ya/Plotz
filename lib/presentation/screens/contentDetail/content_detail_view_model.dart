import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_single_content_tab_view_model.part.dart'; // 컨텐츠 탭뷰 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역
part 'controllerResources/content_detail_video_view_model.part.dart'; // 컨텐츠 비디오 섹션 뷰

class ContentDetailViewModel extends NewBaseViewModel {
  ContentDetailViewModel({
    required ContentRepository contentRepository,
    required LoadContentOfVideoListUseCase loadContentOfVideoList,
    required LoadContentImgListUseCase loadContentImgList,
    required LoadContentDetailInfoUseCase loadContentMainDescription,
    required LoadContentCreditInfoUseCase loadContentCreditInfo,
    required UserRepository userRepository,
    required UserService userService,
    required ContentArgumentFormat argument,
    // required ContentDetailScaffoldController contentDetailScaffoldController,
  })  : _passedArgument = argument,
        _contentRepository = contentRepository,
        _loadContentOfVideoList = loadContentOfVideoList,
        _loadContentImgList = loadContentImgList,
        _loadContentMainDescription = loadContentMainDescription,
        _loadContentCreditInfo = loadContentCreditInfo,
        _userRepository = userRepository,
        _userService = userService;

  // 이전 페이지에서 전달 받는 argument
  final ContentArgumentFormat _passedArgument;

  /// Data Variables
  /// // 컨텐츠탭 정보
  ContentDetailInfo? _contentDescriptionInfo;

  // 컨턴츠 댓글 리스트
  List<YoutubeContentComment>? _contentCommentList;

  // 유튜브 비디오 컨텐츠 정보
  YoutubeVideoContentInfo? _youtubeVideoContentInfo;

  // 컨텐츠 Credit 정보 리스트
  List<ContentCreditInfo>? contentCreditList;

  // 컨텐츠 이미지 리스트
  List<String>? contentImgUrlList;

  // 컨텐츠 에피소드 정보 리스트
  List<ContentEpisodeInfoItem>? _contentEpisodeList;

  // 유튜브 채널
  ChannelInfo? channelInfo;

  // 컨텐츠 비디오(유튜브)
  ContentVideos? contentVideos;

  // 큐레이터 정보
  UserModel? _curator;

  /* [UseCase] */
  final LoadContentDetailInfoUseCase _loadContentMainDescription;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;
  final LoadContentImgListUseCase _loadContentImgList;
  final LoadContentOfVideoListUseCase _loadContentOfVideoList;

  /* Data Modules */
  final ContentRepository _contentRepository;
  final UserRepository _userRepository;
  final UserService _userService;

  /********************** [SCAFFOLD RESOURCES]  **********************/
  late final TabController tabController;
  final ScrollController scrollController = ScrollController();

  /*** [State] Variables ***/
  // 선택된 탭 인덱스
  int selectedTabIndex = 0;

  // Sliver Custom 스크롤 Offset
  double scrollOffset = 0;

  // 상단 '뒤로가기' 버튼 Visibility 여부
  bool showBackBtnOnTop = true;

  /* 메소드 */
  // 탭 바 버튼이 클릭 되었을 때
  void onTabClicked(int index) {
    selectedTabIndex = index;
  }

  // [정보] 탭이 클릭 되었을 때 1회 필요한 api call 실행
  void fetchResourcesIfNeeded() {
    if (tabController.index == 1) {
      fetchContentCreditInfo();
      fetchCuratorInfo();
      fetchContentImgList();
      tabController.removeListener(fetchResourcesIfNeeded);
    }
  }

  // 뒤로가기
  void onRouteBack(BuildContext context) {
    context.pop();
  }

  // 하단 상단 앱바 Visibility 여부를 조절하는 메소드.
  void setBackBtnVisibility() {
    if (scrollController.offset >= 412 && showBackBtnOnTop == true) {
      showBackBtnOnTop = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 482) {
      return;
    } else {
      if (showBackBtnOnTop == false) {
        showBackBtnOnTop = true;
        notifyListeners();
      }
    }
  }

  void onIntentInit(TabController passedTabC) {
    scrollController.addListener(() {
      setBackBtnVisibility();
      scrollOffset = scrollController.offset;
      if (scrollController.offset <= 412) {
        notifyListeners();
      }
    });
    tabController = passedTabC;
    tabController.addListener(fetchResourcesIfNeeded);
  }

  double get headerBgOffset => -scrollOffset * 0.5;

  /********************** [ENDS]  **********************/

  /* [Intent ] */

  /// 유저 시청 기록 추가
  Future<void> addUserWatchHistory(String videoId) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value.id!,
      originId: passedArgument.originId,
      videoId: videoId,
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

  /// Networking Method

  // 큐레이터 정보 호출
  Future<void> fetchCuratorInfo() async {
    final response =
        await _contentRepository.loadCuratorInfo(passedArgument.originId);
    response.fold(
      onSuccess: (data) {
        _curator = data;
        notifyListeners();
      },
      onFailure: (e) {
        log('ContentDetailViewModel : $e');
      },
    );
  }

  /// 컨텐츠 비디오 상세 정보 호출 & 데이터 매핑 로직
  /// 비동기에 유의
  Future<void> fetchAndMappedVideDetailFields() async {
    for (var e in contentVideos!.videos) {
      // Tv 컨텐츠 일 경우 시즌 정보 업데이트
      if (_contentDescriptionInfo?.seasonInfoList != null &&
          passedArgument.contentType == ContentType.tv) {
        await e
            .mappingTvSeasonInfo(
          seasonInfoList: _contentDescriptionInfo!.seasonInfoList!,
        )
            .then((_) async {
          // 로딩 State 업데이트
          await contentVideos!.updateSeasonInfoLoadingState();
          safeUpdate<ContentDetailViewModel>();
        });
      }

      /// 비디오 상세 정보 업데이트
      /// Youtube Api가 실행되는 부분
      await e.updateVideoDetails(context);
    }
  }

  // 컨텐츠에 등록된 비디오(유튜브) 리스트 호출
  Future<void> _fetchContentOfVideoList() async {
    final responseRes = await _loadContentOfVideoList.call(
      passedArgument.contentType,
      passedArgument.originId,
    );

    responseRes.fold(
      onSuccess: (data) {
        contentVideos = data;
        notifyListeners();
        fetchAndMappedVideDetailFields().then((value) async {
          await contentVideos!.updateVideoDetailsLoadingState();
          safeUpdate<ContentDetailViewModel>();
          loadingState = ViewModelLoadingState.done;
        });
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '유튜브 비디오 정보를 불러들이는데 실패했어요', context);
        log('ContentDetailViewModel ${e.toString()}');
      },
    );
  }

  // 컨텐츠 이미지 리스트 호출
  Future<void> fetchContentImgList() async {
    final responseRes = await _loadContentImgList.call(
      passedArgument.contentType,
      passedArgument.contentId,
    );
    responseRes.fold(
      onSuccess: (data) {
        contentImgUrlList = data;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '콘텐츠 이미지 정보를 불러들이는 데 실패했습니다', context);
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
    final responseResult = await _loadContentMainDescription.call(
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
  Future<void> _fetchYoutubeChannelInfo() async {
    final response =
        await _contentRepository.loadChannelInfo(passedArgument.originId);

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
  Future<void> launchYoutubeApp(String? youtubeVideoId) async {
    if (youtubeVideoId == null) {
      return AlertWidget.newToast(
          message: '잠시만 기다려주세요. 데이터를 불러오고 있습니다.', context);
    }
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
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    /// NOTE 호출 순서 주의 [_fetchContentMainInfo]가
    /// 무조건 선행 되어야 함
    await _fetchContentMainInfo();
    await Future.wait([
      _fetchContentOfVideoList(),
      _fetchYoutubeChannelInfo(),
    ]);
  }

  @override
  void onDispose() {
    super.onDispose();
  }

  /* [Getters] */
  // 유튜브 컨텐츠 id
  String? get youtubeContentId =>
      passedArgument.videoId ?? contentVideos?.mainVideoId;

  // 컨텐츠트 타입 (영화 or tv)
  ContentType get contentType => passedArgument.contentType;

  // [ContentSeasonType]의 single 여부
  bool get isSeasonEpisodeContent =>
      _contentDescriptionInfo?.contentEpicType == ContentSeasonType.series;

  // Argument (이전 스크린에서 전달 받은 인자)
  ContentArgumentFormat get passedArgument => _passedArgument;
}
