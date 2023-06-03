import 'dart:developer';
import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:rxdart/subjects.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/domain/model/video/content_video.dart';
import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/domain/useCase/video/load_content_video_info_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_single_content_tab_view_model.part.dart'; // 컨텐츠 탭뷰 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역
part 'controllerResources/content_detail_video_view_model.part.dart'; // 컨텐츠 비디오 섹션 뷰

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel({
    required ContentRepository contentRepository,
    required LoadContentOfVideoListUseCase loadContentOfVideoList,
    required LoadContentImgListUseCase loadContentImgList,
    required LoadContentDetailInfoUseCase loadContentMainDescription,
    required LoadContentCreditInfoUseCase loadContentCreditInfo,
    required UserRepository userRepository,
    required UserService userService,
    required ContentArgumentFormat argument,
    required ChannelRepository channelRepository,
    required LoadContentVideoInfoUseCase loadContentVideoInfoUseCase,
    // required ContentDetailScaffoldController contentDetailScaffoldController,
  })  : _passedArgument = argument,
        _contentRepository = contentRepository,
        _loadContentOfVideoList = loadContentOfVideoList,
        _loadContentImgList = loadContentImgList,
        _loadContentMainDescription = loadContentMainDescription,
        _loadContentCreditInfo = loadContentCreditInfo,
        _userRepository = userRepository,
        _userService = userService,
        _channelRepository = channelRepository,
        loadContentVideoInfo = loadContentVideoInfoUseCase;

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

  // 채널의 다른 콘텐츠
  List<NewContentPosterShell>? channelRelatedContents;

  // 유튜브 채널
  ChannelInfo? channelInfo;

  // 컨텐츠 비디오(유튜브)
  OldContentVideos? oldContentVideos;

  // 컨텐츠 비디오(유튜브)
  ContentVideoModel? videoInfo;

  // 큐레이터 정보
  UserModel? _curator;

  /* [UseCase] */
  final LoadContentDetailInfoUseCase _loadContentMainDescription;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;
  final LoadContentImgListUseCase _loadContentImgList;
  final LoadContentOfVideoListUseCase _loadContentOfVideoList;
  final LoadContentVideoInfoUseCase loadContentVideoInfo;

  /* Data Modules */
  final ContentRepository _contentRepository;
  final UserRepository _userRepository;
  final UserService _userService;
  final ChannelRepository _channelRepository;

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
    if (scrollController.offset >= 430 &&
        showBackBtnOnTop == true &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      showBackBtnOnTop = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 486) {
      return;
    } else {
      if (showBackBtnOnTop == false &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        showBackBtnOnTop = true;
        notifyListeners();
      }
    }
  }

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
      builder: (context) {
        return Padding(
          padding: AppInset.horizontal16,
          child: Wrap(
            children: [
              Container(
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColor.gray07,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                width: double.infinity,
                child: Center(
                  child: Text(
                    '영상 선택',
                    style: AppTextStyle.alert2.copyWith(color: AppColor.gray03),
                  ),
                ),
              ),
              Container(
                height: 0.5,
                width: double.infinity,
                color: AppColor.gray06,
              ),
              ListView.separated(
                separatorBuilder: (_, __) => Container(
                  height: 0.5,
                  width: double.infinity,
                  color: AppColor.gray06,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: videoInfo!.videos.length,
                itemBuilder: (context, index) {
                  final bool isLastItem = videoInfo!.videos.length == index + 1;
                  return MaterialButton(
                    color: AppColor.gray07,
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: isLastItem
                          ? const BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12),
                            )
                          : BorderRadius.zero,
                    ),
                    onPressed: () {
                      selectedEpisode = index + 1;
                      notifyListeners();
                      context.pop();
                    },
                    child: SizedBox(
                      height: 56,
                      child: Center(
                        child: Text(
                          passedArgument.contentType.isMovie
                              ? '${index + 1}부'
                              : '시즌 ${index + 1}',
                          style: AppTextStyle.title2
                              .copyWith(color: AppColor.main),
                        ),
                      ),
                    ),
                  );
                },
              ),

              AppSpace.size8,
              // 하단 버튼
              MaterialButton(
                color: AppColor.gray07,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                onPressed: () {},
                child: const SizedBox(
                  height: 56,
                  child: Center(
                    child: Text(
                      '닫기',
                      style: TextStyle(
                        color: AppColor.white,
                        fontFamily: 'pretendard_regular',
                        fontSize: 14,
                        letterSpacing: -0.2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

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
    for (var e in oldContentVideos!.videos) {
      // Tv 컨텐츠 일 경우 시즌 정보 업데이트
      if (_contentDescriptionInfo?.seasonInfoList != null &&
          passedArgument.contentType == ContentType.tv) {
        await e
            .mappingTvSeasonInfo(
          seasonInfoList: _contentDescriptionInfo!.seasonInfoList!,
        )
            .then((_) async {
          // 로딩 State 업데이트
          await oldContentVideos!.updateSeasonInfoLoadingState();
          safeUpdate<ContentDetailViewModel>();
        });
      }

      /// 비디오 상세 정보 업데이트
      /// Youtube Api가 실행되는 부분
      await e.updateVideoDetails(context);
    }
  }



  // 대표 조회 수
  String? mainViewCount (List<YoutubeVideoContentInfo> videos) {
    if (videos.isEmpty) {
      return null;
    }
    int sum = 0;
    for (YoutubeVideoContentInfo video in videos) {
      sum += video.viewCount;
    }
    return sum.toString();
  }

  // 컨텐츠에 등록된 비디오(유튜브) 리스트 호출
  Future<void> _oldFetchContentOfVideoList() async {
    final responseRes = await _loadContentOfVideoList.call(
      passedArgument.contentType,
      passedArgument.originId,
    );

    responseRes.fold(
      onSuccess: (data) {
        oldContentVideos = data;
        notifyListeners();
        fetchAndMappedVideDetailFields().then((value) async {
          await oldContentVideos!.updateVideoDetailsLoadingState();
          loadingState = ViewModelLoadingState.done;
          safeUpdate<ContentDetailViewModel>();
        });
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '유튜브 비디오 정보를 불러들이는데 실패했어요', context);
        log('ContentDetailViewModel ${e.toString()}');
      },
    );
  }

  Future<void> _fetchVideoInfo() async {
    final responseResult = await loadContentVideoInfo.call(
        contentId: passedArgument.originId,
        contentType: contentType,
        context: context);
    responseResult.fold(onSuccess: (data) {
      print("끝223");
      videoInfo = data;
      if (data.videos.length > 1) {
        selectedEpisode = data.videos[0].episodeNum;
      }
      print("끝2");
      notifyListeners();
    }, onFailure: (e) {
      AlertWidget.newToast(message: '유튜브 비디오 정보를 불러들이는데 실패했어요', context);
      log('ContentDetailViewModel ${e.toString()}');
    });
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

  // 채널의 다른 콘텐츠 리스트 호출 (10개)
  Future<void> fetchChannelContents() async {
    final response = await _channelRepository.loadChannelContentsWithLimit(
        channelId: channelInfo!.id!, currentContentId: passedArgument.originId);
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

  void showYoutubeFetchFailedErr() {
    AlertWidget.newToast(context, message: '유튜브 정보를 불러오는데 실패했어요');
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
      _fetchVideoInfo(),
      _fetchYoutubeChannelInfo().whenComplete(fetchChannelContents),
    ]);
  }

  @override
  void onDispose() {
    super.onDispose();
  }

  /* [Getters] */
  // 유튜브 컨텐츠 id
  String? get youtubeContentId =>
      passedArgument.videoId ?? oldContentVideos?.mainVideoId;

  // 컨텐츠트 타입 (영화 or tv)
  ContentType get contentType => passedArgument.contentType;

  // [ContentSeasonType]의 single 여부
  bool get isSeasonEpisodeContent =>
      _contentDescriptionInfo?.contentEpicType == ContentSeasonType.series;

  // Argument (이전 스크린에서 전달 받은 인자)
  ContentArgumentFormat get passedArgument => _passedArgument;
}
