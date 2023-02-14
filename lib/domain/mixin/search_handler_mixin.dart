import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 202.02.02
 *  검색 로직을 담고 있는 mixin 모듈
 *  해당 모듈은 아래의 기능과 리소스를 가지고 있음
 *  1) 가상 키보드 인터렉션로직 관련 컨트롤러 [focusNode]
 *  2) 검색 바 'x' 버튼 인터렉션 로직 및 상태 변수 [showRoundCloseBtn] [onCloseBtnTapped] [toggleCloseBtn]
 *  3) 검색된 키워드 [term]
 *  4) 검색이 동작이 입력 되었을 때 [onSearchTermEntered] , (override 필요)
 * */

mixin SearchHandlerMixin {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();
  final RxBool showRoundCloseBtn = false.obs;

  String get term => textEditingController.value.text;

  // 검색바 'X' 버튼 토글 로직
  void toggleCloseBtn() {
    final String term = textEditingController.text;
    if (showRoundCloseBtn.isFalse && term.isNotEmpty) {
      showRoundCloseBtn(true);
    }
    if (showRoundCloseBtn.isTrue && term.isEmpty) {
      showRoundCloseBtn(false);
    }
  }

  // 검색바 'X' 버튼이 클릭 되었을 때
  void onCloseBtnTapped() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
  }

  // 검색어가 입력되었을 때
  Future<void> onSearchTermEntered();
}
