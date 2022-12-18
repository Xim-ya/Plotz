import 'package:intl/intl.dart';

class Formatter {
  // ['드라마' , '액션' , '멜로'] --> '드라마 / 액션 / 멜로'
  static String? formatGenreListToSingleStr(List<String>? genreList) =>
      genreList == null ? '-' : genreList.join(' / ');

  // Date Format
  static String dateToyyMMdd(String date) =>
      DateFormat('yy.MM.dd').format(DateTime.parse(date));

  /// 좋아요 수 & 조회수를 유튜브 포맷에 맞게 변경
  /// 1000 미만 -> 숫자 ex) 956
  /// 1000 이상 -> 천 단위 ex) 1.4천
  /// 10000 이상 -> 만 단위 ex) 32만, 이때는 소숫점 없음 && 41000 -> 4.1만
  static String? formatViewAndLikeCount(int? num, {bool? isViewCount}) {
    if (num == null) {
      return null;
    }
    final strNum = '$num';
    if (num <= 1000) {
      return num.toString();
    } else if (num > 1000 && num < 10000) {
      final subString = strNum.substring(0, 2);
      final result = RegExp(r'.{1}')
          .allMatches(subString)
          .map((e) => e.group(0))
          .join('.');
      return '$result${isViewCount ?? false ? '천회' : '천'}';
      // 5 ,
    } else if (num >= 10000) {
      if (strNum.length == 5) {
        final subString = strNum.substring(0, 2);
        final result = RegExp(r'.{1}')
            .allMatches(subString)
            .map((e) => e.group(0))
            .join('.');
        return '$result${isViewCount ?? false ? '만회' : '만'}';
      } else {
        final result = strNum.substring(0, strNum.length - 4);
        return '$result${isViewCount ?? false ? '만회' : '만'}';
      }
    } else {
      return '-';
    }
  }

  // 현재 일을 기준으로 인자로 받은 '날짜'를 계산하여 일정 포맷으로 리턴함
  static String getDateDifferenceFromNow(String? date) {
    if (date == null) {
      return '-';
    }

    int diffSeconds = DateTime.now().difference(DateTime.parse(date)).inSeconds;

    if (diffSeconds < 60) {
      return '$diffSeconds초 전';
    } else if (diffSeconds < 3600) {
      return '${diffSeconds ~/ 60}분 전';
    } else if (diffSeconds < 86400) {
      return '${diffSeconds ~/ 3600}시간 전';
    } else if (diffSeconds < 2592000) {
      return '${diffSeconds ~/ 86400}일 전';
    } else if (diffSeconds < 31536000) {
      return '${diffSeconds ~/ 2592000}달 전';
    } else {
      return '${diffSeconds ~/ 31536000}년 전';
    }
  }
}
