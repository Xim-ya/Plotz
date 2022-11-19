import 'package:intl/intl.dart';

class Formatter {
  // ['드라마' , '액션' , '멜로'] --> '드라마 / 액션 / 멜로'
  static String? formatGenreListToSingleStr(List<String>? genreList) =>
      genreList == null ? '-' : genreList.join(' / ');

  /// Date Format
  static String dateToyyMMdd(String date) =>
      DateFormat('yy.MM.dd').format(DateTime.parse(date));
}
