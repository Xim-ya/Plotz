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
  /// 10000 이상 -> 만 단위 ex) 32만, 이때는 소숫점 없음
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
      return result;
      // 5 ,
    } else if (num >= 10000) {
      // final int aim = strNum.length == 5 ?  : 4;
      // final subString = strNum.substring(0, aim);
      final result = RegExp(r'.{2}')
          .allMatches(strNum)
          .map((e) => e.group(0))
          .join('.');
      return result + '만';
    } else {
      return 'non';
    }
  }
}
