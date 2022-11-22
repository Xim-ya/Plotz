import 'package:intl/intl.dart';

class Formatter {
  // ['드라마' , '액션' , '멜로'] --> '드라마 / 액션 / 멜로'
  static String? formatGenreListToSingleStr(List<String>? genreList) =>
      genreList == null ? '-' : genreList.join(' / ');

  // Date Format
  static String dateToyyMMdd(String date) =>
      DateFormat('yy.MM.dd').format(DateTime.parse(date));

  /// 좋아요 수를 일정 포맷으로 변경
  /// 1000 미만 -> 숫자 ex) 956
  /// 1000 이상 -> 천 단위 ex) 1.4천
  /// 10000 이상 -> 만 단위 ex) 32만, 이때는 소숫점 없음 && 41000 -> 4.1만
  static String formatLikesCount(int num) {
    final strNum = '$num';

    if (num <= 1000) {
      return num.toString();
    } else if (num > 1000 && num < 10000) {
      final subString = strNum.substring(0, 2);
      final result = RegExp(r'.{1}')
          .allMatches(subString)
          .map((e) => e.group(0))
          .join('.');
      return '$result천';
      // 5 ,
    } else if (num >= 10000) {
      if (strNum.length == 5) {
        final subString = strNum.substring(0, 2);
        final result = RegExp(r'.{1}')
            .allMatches(subString)
            .map((e) => e.group(0))
            .join('.');
        return '$result만';
      } else {
        final result = strNum.substring(0, strNum.length - 4);
        return '$result만';
      }
    } else {
      return '-';
    }
  }
}
