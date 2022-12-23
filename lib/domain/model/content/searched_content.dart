import 'package:uppercut_fantube/data/dto/tmdb/response/newResponse/tmdb_tv_detail_response.dart';

/** Created By Ximya - 2022.12.31
 * [SearchScreen]에서 사용되는
 * 검색된 컨텐츠의 아이템 모델
 * [isRegisteredContent] [youtubeVideoId] 필드값은 late으로 선언하여
 * 핵심 정보를 load하고 이후에 받아올 수 있도록 함.
 * */

class SearchedContent {
  final int contentId;
  final String? posterImgUrl; // 컨텐츠 포스트
  final String? title;
  final String? releaseDate;
  late bool isRegisteredContent;
  late String youtubeVideoId;

  SearchedContent(
      {required this.contentId,
      required this.posterImgUrl,
      required this.title,
      required this.releaseDate});

  factory SearchedContent.fromResponse(TmdbTvDetailResponse response) {
    return SearchedContent(
      contentId: response.id,
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.name,
      releaseDate: response.first_air_date,
    );
  }
}
