import 'package:uppercut_fantube/domain/enum/content_type_enum.dart';

/** Created By Ximya - 2022.11.19
 *  홈 스크린 > 상단 컨텐츠 리스트 슬라이더 위젯에서 사용되는 데이터 모델
 * */

class TopExposedContent {
  final int contentId; // TMDB 컨텐츠 id
  final String youtubeId; // 유튜브 비디오 id
  final String title; // 컨텐츠 제목
  final String description; // 컨텐츠 설명 or 유튜브 비디오 제목
  final String thumbnailImgUrl; // 유튜브 썸네일 이미지;
  final String posterImgUrl; // 포스터 이미지 (백그라운드에 이미지로 활용)
  final ContentSeasonType contentSeasonType; // 시리즈물 or 단일 컨텐츠

  TopExposedContent({
    required this.contentSeasonType,
    required this.contentId,
    required this.youtubeId,
    required this.title,
    required this.description,
    required this.posterImgUrl,
    required this.thumbnailImgUrl,
  });

  factory TopExposedContent.fromJson(Map<String, dynamic> json) =>
      TopExposedContent(
        posterImgUrl: json['posterImgUrl'],
        contentSeasonType: ContentSeasonType.fromSeasonCount(json['seasonNumber']),
        thumbnailImgUrl: json['thumbnailImgUrl'],
        contentId: json['id'],
        youtubeId: json['youtubeId'],
        title: json['title'],
        description: json['description'],
      );
}
