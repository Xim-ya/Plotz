/** Created By Ximya - 2022.12.19
 *  [ContentSeasonType]이 'seires'인 컨텐츠 관련 에피소드 정보 아이템 모델
 * */

class ContentEpisodeInfoItem {
  final String overview;
  final String posterUrl;
  final int seasonNumber;
  final String youtubeVideoId;

  ContentEpisodeInfoItem(
      {required this.overview,
      required this.posterUrl,
      required this.seasonNumber,
      required this.youtubeVideoId});

  factory ContentEpisodeInfoItem.fromJson(Map<String, dynamic> json) {
    return ContentEpisodeInfoItem(
      overview: json['overview'],
      posterUrl: json['posterImgUrl'],
      seasonNumber: json['seasonNumber'],
      youtubeVideoId: json['youtubeVideoId'],
    );
  }
}
