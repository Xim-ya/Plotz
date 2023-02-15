import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.11.19
 *  UI에서 포스터가 노출되는 컨텐츠
 *
 *  Edited By Ximya - 2022.12.16
 *  해당 모델 클래스의 일부 필드값을 nullable하게 변경.
 *  홈 섹션에서 사용되는 모델들을 통일.
 * */

class PosterExposureContent {
  final int contentId; // TMDB 컨텐츠 id
  final String videoId; // 유튜브 비디오 id
  final String? title; // 컨텐츠 제목(이름)
  final String? description; // 컨텐츠 설명 or 유튜브 비디오 제목
  final String? thumbnailImgUrl; // 유튜브 썸네일 이미지;
  final String posterImgUrl; // 포스터 이미지 (백그라운드에 이미지로 활용)
  final ContentSeasonType? contentSeasonType; // 시리즈물 or 단일 컨텐
  final List<Video>? videos; // 유튜브 비디오 정보;
  final ContentType contentType; // 영화 or 드라마

  PosterExposureContent({
    this.contentSeasonType,
    this.description,
    this.thumbnailImgUrl,
    this.title,
    this.videos,
    required this.contentType,
    required this.contentId,
    required this.videoId,
    required this.posterImgUrl,
  });

  factory PosterExposureContent.fromJson(Map<String, dynamic> json) =>
      PosterExposureContent(
        posterImgUrl: json['posterImgUrl'],
        contentSeasonType:
            ContentSeasonType.fromSeasonCount(json['seasonNumber']),
        thumbnailImgUrl: json['thumbnailImgUrl'],
        contentId: json['id'],
        videoId: json['videoId'],
        title: json['title'],
        description: json['description'],
        contentType: ContentType.fromString(json['type']),
      );



  factory PosterExposureContent.topExposedContent(Map<String, dynamic> json) {


    return PosterExposureContent(
      posterImgUrl: json['posterImgUrl'],
      contentSeasonType:
          ContentSeasonType.fromSeasonCount(json['seasonNumber']),
      thumbnailImgUrl: json['thumbnailImgUrl'],
      contentId: json['id'],
      videoId: json['videoId'],
      title: json['title'],
      description: json['description'],
      contentType: ContentType.fromString(json['type']),
    );
  }
}
