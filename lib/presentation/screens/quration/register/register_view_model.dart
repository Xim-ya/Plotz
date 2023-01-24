import 'package:uppercut_fantube/utilities/index.dart';

class RegisterViewModel extends BaseViewModel {
  /* Variables */
  final RxList<bool> selectedSteps = <bool>[true, false, false].obs;
  RxBool showRoundCloseBtn = false.obs; // 검색 컨테이너 'x' 버튼 노출여부

  /* Controllers */
  late PageController pageController;
  late FocusNode focusNode;
  late TextEditingController textEditingController;


  /* Intent */

  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
  }

  @override
  void onInit() {
    super.onInit();

    pageController = PageController();
    focusNode = FocusNode();
    textEditingController = TextEditingController();
  }
}
