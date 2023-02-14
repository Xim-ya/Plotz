import 'package:soon_sak/data/dto/content/response/video_response.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.01.01
 * [ContentDetailScreen]에서 사용되는 비디오 객체 정보를 담고 있는 모델
 * [FP] 본 클래스 모델과 nested 객체 모두 FP 성격이 진함.
 * 클래스 안에서 데이터를 호출하고 매핑하는 메소드가 존재
 * */

class ContentVideos {
  final List<ContentVideoItem> videos; // 비디오 객체 (시즌 정보, 유튜브 상세 정보 등등)
  final ContentVideoFormat contentVideoFormat; // 비디오 포맷 타입
  RxBool isDetailInfoLoaded = false.obs;
  RxBool isSeasonInfoLoaded = false.obs;

  /* Getters */
  ContentVideoItem get singleTypeVideo => videos[0];

  List<ContentVideoItem> get multipleTypeVideos => videos;

  // 대표 비디오 url
  String get mainVideoId => videos[0].videoId;

  // 대표 비디오 타이틀
  String? get mainVideoTitle => videos[0].detailInfo?.videoTitle;

  // 대표 영상 업로드일
  String? get mainUploadDate => videos[0].detailInfo?.uploadDate;

  // TODO: 추후 총합으로 수정 필요
  // 대표 조회 수
  int? get mainViewCount => videos[0].detailInfo?.likeCount;

  // 대표 좋아요 수
  int? get mainLikesCount => videos[0].detailInfo?.likeCount;

  /* Intents */
  // 비디오 상세 정보 로딩 state 업데이트
  void updateVideoDetailsLoadingState() {
    isDetailInfoLoaded(true);
  }

  // 비디오 시즌 정보 로딩 state 업데이트
  void updateSeasonInfoLoadingState() {
    isSeasonInfoLoaded(true);
  }

  ContentVideos({required this.videos, required this.contentVideoFormat});

  factory ContentVideos.fromDramaJson(List<Map<String, dynamic>> json) {
    return ContentVideos(
        videos: json.map((e) => ContentVideoItem.fromJson(e)).toList(),
        // 비디오 response 개수에 따라 타입이 결정됨.
        contentVideoFormat: json.length > 1
            ? ContentVideoFormat.multipleTv
            : ContentVideoFormat.singleTv);
  }

  factory ContentVideos.fromMovieJson(List<Map<String, dynamic>> json) {
    return ContentVideos(
        videos: json.map((e) => ContentVideoItem.fromJson(e)).toList(),
        // 비디오 response 개수에 따라 타입이 결정됨.
        contentVideoFormat: json.length > 1
            ? ContentVideoFormat.multipleMovie
            : ContentVideoFormat.singleMovie);
  }

  factory ContentVideos.fromResponse(List<VideoResponse> response,
      {required String id}) {
    final ContentType type = SplittedIdAndType.fromOriginId(id).type;

    ContentVideoFormat getFormatType() {
      if (type.isMovie) {
        return response.length > 1
            ? ContentVideoFormat.multipleMovie
            : ContentVideoFormat.singleMovie;
      } else {
        return response.length > 1
            ? ContentVideoFormat.multipleTv
            : ContentVideoFormat.singleTv;
      }
    }

    return ContentVideos(
        videos: response.map((e) => ContentVideoItem.fromResponse(e)).toList(),
        contentVideoFormat: getFormatType());
  }



}
