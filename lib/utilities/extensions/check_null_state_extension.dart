/** Created By Ximya - 2022.12.09
 * 특정 data가 null인지 확인하는 extension
 * 조건부 위젯 리턴 기능에 가독성을 높이기 위함
 * 데이터 != null  ? aWidget : bWidget (X)
 * 데이터.hasData ? aWidget : bWidget (O)
 * */

extension CheckNullStateExtension on dynamic {
  bool get hasData {
    return this != null ? true : false;
  }
}
