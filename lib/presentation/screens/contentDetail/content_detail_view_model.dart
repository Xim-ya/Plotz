import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_single_content_tab_view_model.part.dart'; // 컨텐츠 탭뷰 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역
part 'controllerResources/content_detail_video_view_model.part.dart'; // 컨텐츠 비디오 섹션 뷰

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(
      this._contentRepository,
      this._loadContentOfVideoList,
      this._loadContentImgList,
      this._loadContentMainDescription,
      this._loadContentCreditInfo,
      {required argument})
      : _passedArgument = argument;

  // 이전 페이지에서 전달 받는 argument
  final ContentArgumentFormat _passedArgument;

  /// Data Variables
  /// // 컨텐츠탭 정보
  final Rxn<ContentDetailInfo> _contentDescriptionInfo = Rxn();

  // 컨턴츠 댓글 리스트
  final Rxn<List<YoutubeContentComment>> _contentCommentList = Rxn();

  // 유튜브 비디오 컨텐츠 정보
  final Rxn<YoutubeVideoContentInfo> _youtubeVideoContentInfo = Rxn();

  // 컨텐츠 Credit 정보 리스트
  final Rxn<List<ContentCreditInfo>> _contentCreditList = Rxn();

  // 컨텐츠 이미지 리스트
  final Rxn<List<String>> contentImgUrlList = Rxn();

  // 컨텐츠 에피소드 정보 리스트
  final Rxn<List<ContentEpisodeInfoItem>> _contentEpisodeList = Rxn();

  // 유튜브 채널
  final Rxn<YoutubeChannelInfo> youtubeChannelInfo = Rxn();

  // 컨텐츠 비디오(유튜브)
  final Rxn<ContentVideos> contentVideos = Rxn();

  // 큐레이터 정보
  final Rxn<UserModel> _curator = Rxn();

  /* [UseCase] */
  final LoadContentDetailInfoUseCase _loadContentMainDescription;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;
  final LoadContentImgListUseCase _loadContentImgList;
  final LoadContentOfVideoListUseCase _loadContentOfVideoList;

  /* Data Modules */
  final ContentRepository _contentRepository;

  /* [Intent ] */

  /// 이전 페이지로 이동
  void onRouteBack() {
    // Get.argument 로딩중이 아니라면 이라면
    if (loading.isFalse) {
      Get.back();
    }
  }

  /// Networking Method

  // 큐레이터 정보 호출
  Future<void> fetchCuratorInfo() async {
    final response = await _contentRepository
        .loadCuratorInfo(_contentDescriptionInfo.value!.originId);
    response.fold(
      onSuccess: (data) {
        _curator.value = data;
      },
      onFailure: (e) {
        log('ContentDetailViewModel : $e');
      },
    );
  }

  /// 컨텐츠 비디오 상세 정보 호출 & 데이터 매핑 로직
  /// 비동기에 유의
  Future<void> fetchAndMappedVideDetailFields() async {
    for (var e in contentVideos.value!.videos) {
      // Tv 컨텐츠 일 경우 시즌 정보 업데이트
      if (_contentDescriptionInfo.value?.seasonInfoList != null &&
          passedArgument.contentType == ContentType.tv) {
        await e
            .mappingTvSeasonInfo(
                seasonInfoList: _contentDescriptionInfo.value!.seasonInfoList!)
            .then((value) {
          // 로딩 State 업데이트
          contentVideos.value!.updateSeasonInfoLoadingState();
        });
      }

      await e.updateVideoDetails(); // 비디오 상세 정보 업데이트
    }
  }

  // 컨텐츠에 등록된 비디오(유튜브) 리스트 호출
  Future<void> fetchContentOfVideoList() async {
    final responseRes = await _loadContentOfVideoList.call(
        passedArgument.contentType, passedArgument.originId);

    responseRes.fold(
      onSuccess: (data) {
        contentVideos.value = data;

        fetchAndMappedVideDetailFields().then((value) {
          contentVideos.value!
              .updateVideoDetailsLoadingState(); // <-- 컨텐츠 로드 완료 필드 값 업데이트
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
        passedArgument.contentType, passedArgument.contentId);
    responseRes.fold(onSuccess: (data) {
      contentImgUrlList.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('컨텐츠 이미지 정보를 불러들이는 데 실패했습니다');
      log(e.toString());
    });
  }

  // 컨텐츠 credit 정보 호출
  Future<void> fetchContentCreditInfo() async {
    final responseRes = await _loadContentCreditInfo.call(
        passedArgument.contentType, passedArgument.contentId);

    responseRes.fold(onSuccess: (data) {
      _contentCreditList.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('출연진 정보를 불러들이는 데 실패했습니다');
      log(e.toString());
    });
  }

  // 컨텐츠 상세 정보(TMDB) 호출
  Future<void> _fetchContentMainInfo() async {
    final responseResult = await _loadContentMainDescription.call(
        passedArgument.contentType, passedArgument.contentId);
    responseResult.fold(
      onSuccess: (data) {
        _contentDescriptionInfo.value = data;
        update();
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 컨텐츠 댓글 리스트 호출
  Future<void> _fetchContentCommentList() async {
    final responseResult =
        await YoutubeRepository.to.loadContentCommentList(youtubeContentId!);
    responseResult.fold(
      onSuccess: (data) {
        _contentCommentList.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 유튜브 채널 정보 호출
  Future<void> fetchYoutubeChannelInfo() async {
    final responseResult =
        await YoutubeRepository.to.loadYoutubeChannelInfo(youtubeContentId!);
    responseResult.fold(onSuccess: (data) {
      youtubeChannelInfo.value = data;
    }, onFailure: (e) {
      // TODO: Repository 레이어에서 Exception 처리
      if (e.runtimeType == VideoUnavailableException) {
        AlertWidget.toast('업로더가 비디오를 삭제했습니다');
      } else {
        AlertWidget.toast('유튜브 정보를 불러오는데 실패하였습니다');
      }
      log(e.toString());
      log('${e.runtimeType} 타입'); // -> VideoUnavailableException (비디오 유실)
    });
  }

  /// Routing Method
  // 전달 받은 컨텐츠 유튜브 id 값으로 youtubeApp 실행
  Future<void> launchYoutubeApp(String? youtubeVideoId) async {
    if (youtubeVideoId == null) {
      return AlertWidget.toast('잠시만 기다려주세요. 데이터를 불러오고 있습니다.');
    }
    if (!await launchUrl(
      Uri.parse('https://www.youtube.com/watch?v=$youtubeVideoId'),
      mode: LaunchMode.externalApplication,
    )) {
      throw '유튜브 앱(웹) 런치 실패';
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await _fetchContentMainInfo();
    await fetchContentOfVideoList();
    await _fetchContentCommentList();
  }

  /* [Getters] */
  // 유튜브 컨텐츠 id
  String? get youtubeContentId =>
      passedArgument.videoId ?? contentVideos.value?.mainVideoId;

  // 컨텐츠트 타입 (영화 or tv)
  ContentType get contentType => passedArgument.contentType;

  // [ContentSeasonType]의 single 여부
  bool get isSeasonEpisodeContent =>
      _contentDescriptionInfo.value?.contentEpicType ==
      ContentSeasonType.series;

  // Argument (이전 스크린에서 전달 받은 인자)
  ContentArgumentFormat get passedArgument => _passedArgument;

  static ContentDetailViewModel get to => Get.find<ContentDetailViewModel>();
}
