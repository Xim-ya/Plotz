import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.01.01
 * [ContentDetailScreen]에서 사용되는 비디오 객체 정보를 담고 있는 모델
 * [FP] 본 클래스 모델과 nested 객체 모두 FP 성격이 진함.
 * 클래스 안에서 데이터를 호출하고 매핑하는 메소드가 존재
 * */

class OldContentVideos {
  final List<OldContentVideoItem> videos; // 비디오 객체 (시즌 정보, 유튜브 상세 정보 등등)
  final ContentVideoFormat contentVideoFormat; // 비디오 포맷 타입
  bool isDetailInfoLoaded = false;
  bool isSeasonInfoLoaded = false;

  OldContentVideos({required this.videos, required this.contentVideoFormat});

  /* Getters */
  OldContentVideoItem get singleTypeVideo => videos[0];

  List<OldContentVideoItem> get multipleTypeVideos => videos;

  // 대표 비디오 url
  String get mainVideoId => videos[0].videoId;

  // 대표 비디오 타이틀
  String? get mainVideoTitle => videos[0].detailInfo?.videoTitle;

  // 대표 영상 업로드일
  String? get mainUploadDate => videos[0].detailInfo?.uploadDate;

  // 대표 조회 수
  int? get mainViewCount {
    if (videos.isEmpty) {
      return null;
    }
    int sum = 0;
    for (OldContentVideoItem video in videos) {
      sum += video.detailInfo?.viewCount ?? 0;
    }
    return sum;
  }

  // 대표 좋아요 수
  int? get mainLikesCount {
    if (videos.isEmpty) {
      return null;
    }
    int sum = 0;
    for (OldContentVideoItem video in videos) {
      sum += video.detailInfo?.likeCount ?? 0;
    }
    return sum;
  }

  /* Intents */
  // 비디오 상세 정보 로딩 state 업데이트
  Future<void> updateVideoDetailsLoadingState() async {
    isDetailInfoLoaded = true;
  }

  // 비디오 시즌 정보 로딩 state 업데이트
  Future<void> updateSeasonInfoLoadingState() async {
    isSeasonInfoLoaded = true;
  }

  factory OldContentVideos.fromResponse(
    List<OldVideoResponse> response, {
    required String id,
  }) {
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

    return OldContentVideos(
      videos: response.map((e) => OldContentVideoItem.fromResponse(e)).toList(),
      contentVideoFormat: getFormatType(),
    );
  }
}

// factory ContentVideos.fromDramaJson(List<Map<String, dynamic>> json) {
//   return ContentVideos(
//     videos: json.map(ContentVideoItem.fromJson).toList(),
//     // 비디오 response 개수에 따라 타입이 결정됨.
//     contentVideoFormat: json.length > 1
//         ? ContentVideoFormat.multipleTv
//         : ContentVideoFormat.singleTv,
//   );
// }
//
// factory ContentVideos.fromMovieJson(List<Map<String, dynamic>> json) {
//   return ContentVideos(
//     videos: json.map(ContentVideoItem.fromJson).toList(),
//     // 비디오 response 개수에 따라 타입이 결정됨.
//     contentVideoFormat: json.length > 1
//         ? ContentVideoFormat.multipleMovie
//         : ContentVideoFormat.singleMovie,
//   );
// }