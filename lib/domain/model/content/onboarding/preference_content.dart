import 'package:soon_sak/domain/enum/movie_genre_enum.dart';

/** Created By Ximya - 2023.06.18
 *  온보딩 섹션에서 사용되는
 *  유저 취향 옵션 콘텐츠 모델
 * */

class PreferredContent {
  final String posterImgUrl;
  final String contentId;
  final List<ContentGenre> genres;

  PreferredContent({
    required this.posterImgUrl,
    required this.contentId,
    required this.genres,
  });
}
