import 'dart:developer';
import 'package:uppercut_fantube/domain/model/content/tv_content_credit_info.dart';
import 'package:uppercut_fantube/domain/model/youtube/youtube_content_comment.dart';
import 'package:uppercut_fantube/domain/model/youtube/youtube_video_content_info.dart';
import 'package:uppercut_fantube/domain/useCase/tmdb/load_content_credit_info_use_case.dart';
import 'package:uppercut_fantube/presentation/common/alert_widget.dart';
import 'package:uppercut_fantube/utilities/extensions/check_null_state_extension.dart';
import 'package:uppercut_fantube/utilities/formatter.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'controllerResources/content_detail_view_model.part.dart';

part 'controllerResources/content_info_view_model.part.dart';

part 'controllerResources/content_detail_header_view_model.part.dart'; // 헤더 영역
part 'controllerResources/content_detail_single_content_tab_view_model.part.dart'; // 싱글 컨텐츠 탭뷰 영역
part 'controllerResources/content_detail_info_tab_view_model.part.dart'; // 컨텐츠 정보 탭뷰 영역

class ContentDetailViewModel extends BaseViewModel {
  ContentDetailViewModel(
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

  /* [UseCase] */
  final LoadContentMainDescriptionUseCase _loadContentMainDescription;
  final LoadContentCreditInfoUseCase _loadContentCreditInfo;

  /* [Intent ] */

  /// Networking Method

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
  bool get isSingleEpisodeContent =>
      _contentDescriptionInfo.value?.contentEpicType ==
      ContentSeasonType.single;

  // 홈 스크린에서 전달 받은 Argument
  ContentDetailParam get passedArgument => Get.arguments;

  static ContentDetailViewModel get to => Get.find<ContentDetailViewModel>();
}
