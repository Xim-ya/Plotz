import 'dart:developer';
import 'package:uppercut_fantube/utilities/index.dart';
part 'content_detail_view_model.part.dart';

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(this._loadContentMainDescription);

  /* [Variables] */
  late int contentId = Get.arguments[0];

  /// Data Variables
  /// // 헤더 + 컨텐츠탭 데이터
  final Rxn<ContentDescriptionInfo> _contentDescriptionInfo = Rxn();

  // 컨텐츨 댓글 리스트
  final Rxn<CommentsList?> _contentCommentList = Rxn();

  /* [UseCase] */
  final LoadContentMainDescriptionUseCase _loadContentMainDescription;

  /* [Intent ] */

  /// Networking Method
  // 컨텐츠 상단 핵심 정보
  Future<void> fetchContentMainInfo() async {
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
  Future<void> fetchContentCommentList() async {
    final responseResult = await ContentRepository.to
        .loadContentCommentList(youtubeContentId ?? '');
    responseResult.fold(onSuccess: (data) {
      _contentCommentList.value = data;
    }, onFailure: (e) {
      log(e.toString());
    });
  }

  /// Routing Method
  // 전달 받은 컨텐츠 유튜브 id 값으로 youtubeApp 실행
  Future<void> launchYoutubeApp() async {
    if (!await launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=${youtubeContentId ?? ''}'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
  }

  @override
  void onInit() {
    super.onInit();

    fetchContentMainInfo();
    fetchContentCommentList();
  }

  ContentDescriptionInfo? get contentMainInfo => _contentDescriptionInfo.value;

  bool get isContentMainInfoLoading => _contentDescriptionInfo.value == null;

  bool get isSingleEpisodeContent =>
      _contentDescriptionInfo.value?.contentEpicType ==
      ContentSeasonType.single;

  ContentDetailParam get passedArgument =>
      Get.arguments; // 홈 스크린에서 전달 받은 Argument
}
