import 'dart:developer';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
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

  /* [Intent ] */

  /// 유저 시청 기록 추가
  Future<void> addUserWatchHistory(String videoId) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value!.id!,
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

  /// 이전 페이지로 이동
  void onRouteBack() {
    // Get.argument 로딩중이 아니라면 이라면
    if (loading == true) {
      Get.back();
    }
  }

  /// Networking Method

  // 큐레이터 정보 호출
  Future<void> fetchCuratorInfo() async {
    final response =
        await _contentRepository.loadCuratorInfo(passedArgument.originId);
    response.fold(
      onSuccess: (data) {
        _curator = data;
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
            .then((value) {
          // 로딩 State 업데이트
          contentVideos!.updateSeasonInfoLoadingState();
          notifyListeners();
        });
      }

      /// 비디오 상세 정보 업데이트
      /// Youtube Api가 실행되는 부분

      await e.updateVideoDetails().whenComplete(() => notifyListeners);
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

        fetchAndMappedVideDetailFields().then((value) {
          contentVideos!.updateVideoDetailsLoadingState();
          notifyListeners(); // <-- 컨텐츠 로드 완료 필드 값 업데이트
        });
      },
      onFailure: (e) {
        AlertWidget.toast('유튜브 비디오 정보를 불러들이는데 실패했어요');
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
      },
      onFailure: (e) {
        AlertWidget.toast('콘텐츠 이미지 정보를 불러들이는 데 실패했습니다');
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
      },
      onFailure: (e) {
        AlertWidget.toast('출연진 정보를 불러들이는 데 실패했습니다');
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

  // 컨텐츠 댓글 리스트 호출
  // Future<void> _fetchContentCommentList() async {
  //   final responseResult =
  //       await YoutubeRepository.to.loadContentCommentList(youtubeContentId!);
  //   responseResult.fold(
  //     onSuccess: (data) {
  //       _contentCommentList = data;
  //     },
  //     onFailure: (e) {
  //       log(e.toString());
  //     },
  //   );
  // }

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
        AlertWidget.animatedToast('채널 정보를 받아오지 못했습니다');
        log('ChannelDetailViewModel : $e');
      },
    );
  }

  /// Routing Method
  // 전달 받은 컨텐츠 유튜브 id 값으로 youtubeApp 실행
  Future<void> launchYoutubeApp(String? youtubeVideoId) async {
    if (youtubeVideoId == null) {
      return AlertWidget.animatedToast('잠시만 기다려주세요. 데이터를 불러오고 있습니다.');
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
      await AlertWidget.animatedToast('비디오 정보를 불러오지 못했습니디');
      throw '유튜브 앱(웹) 런치 실패';
    }

    // 시청기록 추가
    await addUserWatchHistory(youtubeVideoId);
  }

  Future<void> repeatComputeTest() async {
    DateTime startTime = DateTime.now();

    for (int i = 0; i < 30; i++) {
      await _fetchContentMainInfo();
    }

    // 메소드 실행이 완료된 후의 시간을 종료 시간으로 기록
    DateTime endTime = DateTime.now();

    // 두 시간의 차이를 계산
    Duration elapsedTime = endTime.difference(startTime);

    // 실행 시간 출력
    print('비동기 메소드 실행 시간: ${elapsedTime.inMilliseconds} 초');
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    /// NOTE 호출 순서 주의 [_fetchContentMainInfo]가
    /// 무조건 선행 되어야 함
    // await _fetchContentMainInfo();
    // await _fetchContentOfVideoList();
    // await _fetchYoutubeChannelInfo();

    await Future.wait([
      _fetchContentOfVideoList(),
      _fetchContentMainInfo(),
      _fetchYoutubeChannelInfo(),
    ]);
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
