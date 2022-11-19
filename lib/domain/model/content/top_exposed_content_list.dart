/** Created By Ximya - 2022.11.19
 *  홈 스크린 > 상단 컨텐츠 리스트 슬라이더 위젯에서 사용되는 데이터 모델
 * */

class TopExposedContent {
  final int contentId; // TMDB 컨텐츠 id
  final String youtubeId; // 유튜브 비디오 id
  final String title; // 컨텐츠 제목
  final String description; // 컨텐츠 설명 or 유튜브 비디오 제목
  final String posterImgUrl; // 포스터 이미지 (백그라운드에 이미지로 활용)

  TopExposedContent(
      {required this.contentId,
      required this.youtubeId,
      required this.title,
      required this.description,
      required this.posterImgUrl});

  factory TopExposedContent.fromJson(Map<String, dynamic> json) =>
      TopExposedContent(
        contentId: json['id'],
        youtubeId: json['youtubeId'],
        title: json['title'],
        description: json['description'],
        posterImgUrl: json['posterImgUrl'],
      );
}
