/** Created By Ximya - 202l
 *  문자열의 마지막 요소의 반환 하는 extension
 * */

extension StringExtenstion on String {
  String get getLastCharacter {
    if (length > 1) {
      return substring(length - 1, length);
    } else {
      return '';
    }
  }
}
