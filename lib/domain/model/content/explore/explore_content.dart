import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2023.01.14
 *  탐색 스크린에서 사용되는 데이터 모델.
 * */

class ExploreContent {
  ExploreContent({required this.idInfo});

  final ExploreContentIdInfo idInfo; // contentId, videoId
  late final Rxn<ExploreContentYoutubeInfo> _youtubeInfo = Rxn(); // 컨텐츠 유튜브 정보
  late final Rxn<ExploreContentDetailInfo> _detailInfo =
      Rxn(); // 컨텐츠 상세 정보 (TMDB)
  final RxBool isUpdated = false.obs; // 유튜브 정보, 상세 정보 업데이트 여부

  ExploreContentYoutubeInfo? get youtubeInfo => _youtubeInfo.value;

  ExploreContentDetailInfo? get detailInfo => _detailInfo.value;

  /* Intents */
  // 유튜브 정보 업데이트
  Future<void> updateYoutubeChannelInfo() async {
    final channelRes =
        await YoutubeMetaData.yt.channels.getByVideo(idInfo.videoId);
    final videoRes = await YoutubeMetaData.yt.videos.get(idInfo.videoId);
    _youtubeInfo.value = ExploreContentYoutubeInfo.fromResponse(
        channelRes: channelRes, videoRes: videoRes);
  }

  // 컨텐츠 상세 정보 업데이트 (TMDMB)
  Future<void> updateContentDetailInfo() async {
    final ExploreContentDetailInfo responseResult;

    if (idInfo.contentType == ContentType.movie) {
      final response =
          await TmdbDataSource.to.loadTmdbMovieDetailResponse(idInfo.contentId);
      responseResult = ExploreContentDetailInfo.fromMovieResponse(response);
    } else {
      final response =
          await TmdbDataSource.to.loadTmdbTvDetailResponse(idInfo.contentId);
      responseResult = ExploreContentDetailInfo.fromTvResponse(response);
    }
    _detailInfo.value = responseResult;
  }

  // 기본 (contentId, youtubeId , contentType) 값을 초기화하는 factory 메소드
  factory ExploreContent.fromIdInfoResponse(ExploreContentIdInfo response) {
    return ExploreContent(idInfo: response);
  }
}
