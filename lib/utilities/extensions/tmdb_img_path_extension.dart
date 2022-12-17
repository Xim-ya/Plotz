/** Created By Ximya - 2022.11.20
 *  [TMDB]원본 이미지 Path를 붙여서 리턴하는 extension
 * */

extension TmdbImgPathExtension on String {
  String get prefixTmdbImgPath {
    return 'https://image.tmdb.org/t/p/original${this}';
  }
}
