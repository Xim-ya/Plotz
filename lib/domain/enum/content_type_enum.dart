/** Created By Ximya - 2022.11.18
 *  '시리즈 컨텐츠' '단일 컨텐츠'로 구분됨.
 *  '시리즈 개수'를 전달 받고 1인 경우 [single] 반대의 경우 [series]를 리턴
 */

enum ContentSeasonType {
  single,
  series;


  factory ContentSeasonType.fromSeasonCount(int seasonNum) {
    if (seasonNum <= 1) {
      return ContentSeasonType.single;
    } else {
      return ContentSeasonType.series;
    }
  }
}