import 'package:uppercut_fantube/domain/model/content/content.dart';
import 'package:uppercut_fantube/utilities/index.dart';

mixin SearchHandlerMixin {
  final FocusNode focusNode = FocusNode();
  final TextEditingController textEditingController =
      TextEditingController();
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
