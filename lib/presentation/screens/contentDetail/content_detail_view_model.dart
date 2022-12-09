import 'dart:developer';
import 'package:uppercut_fantube/domain/model/youtube/youtube_content_comment.dart';
import 'package:uppercut_fantube/domain/model/youtube/youtube_video_content_info.dart';
import 'package:uppercut_fantube/utilities/extensions/check_null_state_extension.dart';
import 'package:uppercut_fantube/utilities/formatter.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'controllerResources/content_detail_view_model.part.dart';
part 'controllerResources/content_info_view_model.part.dart';
part 'controllerResources/content_detail_header_view_model.part.dart';

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(this._loadContentMainDescription);

  /* [Variables] */
  late int contentId = Get.arguments[0];

  /// Data Variables
  /// // 컨텐츠탭 정보
  final Rxn<ContentDescriptionInfo> _contentDescriptionInfo = Rxn();

  // 컨턴츠 댓글 리스트
  final Rxn<List<YoutubeContentComment>> _contentCommentList = Rxn();

  // 유튜브 비디오 컨텐츠 정보
  final Rxn<YoutubeVideoContentInfo> _youtubeVideoContentInfo = Rxn();

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
    final responseResult = await YoutubeRepository.to
        .loadContentCommentList(youtubeContentId);
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
  Future<void> fetchYoutubeVideoContentInfo() async {
    final responseResult = await YoutubeRepository.to
        .loadYoutubeVideoContentInfo(youtubeContentId);
    responseResult.fold(
      onSuccess: (data) {
        _youtubeVideoContentInfo.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
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
    fetchYoutubeVideoContentInfo();
    fetchContentCommentList();

  }

  /* [Getters] */
  ContentDescriptionInfo? get contentMainInfo => _contentDescriptionInfo.value;

  // 유튜브 컨텐츠 id => 항상 argument로 전달받음
  String get youtubeContentId => passedArgument.youtubeId;

  // [ContentSeasonType]의 single 여부
  bool get isSingleEpisodeContent =>
      _contentDescriptionInfo.value?.contentEpicType ==
      ContentSeasonType.single;

  ContentDetailParam get passedArgument =>
      Get.arguments; // 홈 스크린에서 전달 받은 Argument
}
