import 'package:flutter/cupertino.dart';
import 'package:uppercut_fantube/presentation/base/base_view_model.dart';

class SearchViewModel extends BaseViewModel {

  /* Controllers */
  late TextEditingController textEditingController;

  /* Intents */
  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue(){
    textEditingController.text = '';
  }



  @override
  void onInit() {
    super.onInit();

    textEditingController= TextEditingController();
  }
}
