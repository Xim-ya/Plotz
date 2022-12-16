import 'dart:developer';
import 'package:uppercut_fantube/utilities/index.dart';

part 'controllerResources/content_detail_view_model.part.dart';
part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_single_content_tab_view_model.part.dart'; // 컨텐츠 탭뷰 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(this._loadContentImgList,
      this._loadContentMainDescription, this._loadContentCreditInfo);

  /* [Variables] */
  late int contentId = Get.arguments[0];

  /// Data Variables
  /// // 컨텐츠탭 정보
  final Rxn<ContentDescriptionInfo> _contentDescriptionInfo = Rxn();

  // 컨턴츠 댓글 리스트
  final Rxn<List<YoutubeContentComment>> _contentCommentList = Rxn();

  // 유튜브 비디오 컨텐츠 정보
  final Rxn<YoutubeVideoContentInfo> _youtubeVideoContentInfo = Rxn();

  // 컨텐츠 Credit 정보 리스트
  final Rxn<List<ContentCreditInfo>> _contentCreditList = Rxn();

  // 컨텐츠 이미지 리스트
  final Rxn<List<String>> _contentImgUrlList = Rxn();

  // 컨텐츠 에피소드 정보 리스트
  final Rxn<List<ContentEpisodeInfoItem>> _contentEpisodeList = Rxn();

  /* [UseCase] */
  final LoadContentMainDescriptionUseCase _loadContentMainDescription;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;
  final LoadContentImgListUseCase _loadContentImgList;

  /* [Intent ] */

  /// Networking Method

  // 컨텐츠 에피소드 정보 호출 (시즌 컨텐츠인 경우에만 호출)
  Future<void> fetchEpisodeItemList() async {
    print("발동 ${isSeasonEpisodeContent}");
    if (isSeasonEpisodeContent) {
      print("발동1");
      final responseResult =
          await ContentRepository.to.loadContentEpisodeItemList();
      responseResult.fold(
        onSuccess: (data) {
          _contentEpisodeList.value = data;
        },
        onFailure: (e) {
          AlertWidget.toast('컨텐츠 시즌 리스트 정보를 불러들이는 데 실패했습니다');
          log(e.toString());
        },
      );
    } else {
      print("발동2");
      return;
    }
  }

  // 컨텐츠 이미지 리스트 호출
  Future<void> fetchContentImgList() async {
    final responseRes =
        await _loadContentImgList.call('tv', passedArgument.contentId);
    responseRes.fold(onSuccess: (data) {
      _contentImgUrlList.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('컨텐츠 이미지 정보를 불러들이는 데 실패했습니다');
      log(e.toString());
    });
  }

  // 컨텐츠 credit 정보 호출
  Future<void> fetchContentCreditInfo() async {
    final responseRes =
        await _loadContentCreditInfo.call('tv', passedArgument.contentId);

    responseRes.fold(onSuccess: (data) {
      _contentCreditList.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('출연진 정보를 불러들이는 데 실패했습니다');
      log(e.toString());
    });
  }

  // 컨텐츠 상세 정보(TMDB) 호출
  Future<void> _fetchContentMainInfo() async {
    // final responseResult =
    // await TmdbRepository.to.loadTmdbDetailResponse(passedArgument.contentId);
    // 임시 파라미터
    final responseResult =
        await _loadContentMainDescription.call('tv', passedArgument.contentId);
    responseResult.fold(
      onSuccess: (data) {
        _contentDescriptionInfo.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 컨텐츠 댓글 리스트 호출
  Future<void> _fetchContentCommentList() async {
    final responseResult =
        await YoutubeRepository.to.loadContentCommentList(youtubeContentId);
    responseResult.fold(
      onSuccess: (data) {
        _contentCommentList.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 유튜브 비디오 컨텐츠 정보 호출
  Future<void> _fetchYoutubeVideoContentInfo() async {
    final responseResult = await YoutubeRepository.to
        .loadYoutubeVideoContentInfo(youtubeContentId);
    responseResult.fold(
      onSuccess: (data) {
        _youtubeVideoContentInfo.value = data;
        fetchEpisodeItemList();
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  /// Routing Method
  // 전달 받은 컨텐츠 유튜브 id 값으로 youtubeApp 실행
  Future<void> launchYoutubeApp(String youtubeVideoId) async {
    if (!await launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=$youtubeVideoId'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    await Future.wait([
      _fetchContentMainInfo(),
      _fetchYoutubeVideoContentInfo(),
      _fetchContentCommentList(),
    ]);
  }

  /* [Getters] */
  // 유튜브 컨텐츠 id => 항상 argument로 전달받음
  String get youtubeContentId => passedArgument.youtubeId;

  // [ContentSeasonType]의 single 여부
  bool get isSeasonEpisodeContent =>
      _contentDescriptionInfo.value?.contentEpicType ==
      ContentSeasonType.series;

  // 홈 스크린에서 전달 받은 Argument
  ContentDetailParam get passedArgument => Get.arguments;

  static ContentDetailViewModel get to => Get.find<ContentDetailViewModel>();
}
