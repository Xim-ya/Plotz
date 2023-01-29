import 'dart:async';
import 'package:flutter/services.dart';
import 'package:uppercut_fantube/domain/enum/validation_state_enum.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'controllerResource/search_content_view_model.part.dart'; // 컨텐츠 검색
part 'controllerResource/register_video_link_view_model.part.dart'; // 영상 링크 등록

class RegisterViewModel extends BaseViewModel {
  RegisterViewModel(this._pagingHandler, {required contentType})
      : selectedContentType = contentType;

  /* Variables */
  // 선택된 컨텐츠 타입
  final ContentType selectedContentType;

  // 등록 컨텐츠 진행 단계
  final RxList<bool> selectedSteps = <bool>[true, false, false].obs;

  // 검색 컨테이너 'x' 버튼 노출여부
  RxBool showRoundCloseBtn = false.obs;

  // 검색 api call 시간 딜레이
  Timer? _debounce;

  // 선택된 컨텐츠의 id
  RxInt selectedContentId = 0.obs;

  // 현재 pageView Index
  int get currentPageViewIndex => pageViewController.page?.toInt() ?? 0;

  // 입력된 비디오 링크 유효 여부
  Rx<ValidationState> isEnteredVideoUrlValid = ValidationState.initState.obs;

  // 검색어
  String get searchedKeyword  => textEditingController.text;

  /* Controllers */
  late PageController pageViewController;
  late FocusNode focusNode;

  TextEditingController get textEditingController =>
      _pagingHandler.textEditingController;

  PagingController<int, SearchedContent> get pagingController =>
      _pagingHandler.pagingController;

  /* UseCases */
  final PagingHandlerUseCase _pagingHandler;

  /* Intents */

  /// 하단 고정 버튼이 클릭 시
  /// pageView 현재 인덱스에 따라 동작을 다르게 함.
  void onFloatingStepBtnTapped() {
    switch (currentPageViewIndex) {
      case 0:
        pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        textEditingController.text = '';
        selectedContentId(0);
        show1StepFloatingBtn(false);
        pagingController.refresh();
        break;
      case 1:
        pageViewController.animateToPage(
          2,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        textEditingController.text = '';
        show2StepFloatingBtn(false);
        break;
    }
  }

  // 뒤로가기 버튼 클릭 시
  void onBackBtnTapped() {
    textEditingController.text = ''; // 검색어 초기화
    focusNode.unfocus(); // 키보드 가리기

    switch (currentPageViewIndex) {
      case 0:
        Get.back();
        break;
      case 1:
        isEnteredVideoUrlValid(ValidationState.initState);
        pageViewController.animateToPage(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
      case 2:
        pageViewController.animateToPage(
          1,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
        break;
    }
  }

  //  검색 바 'x' 버튼 노출 여부 로직
  void toggleSearchBarClosedBtn() {
    if (searchedKeyword.isNotEmpty && showRoundCloseBtn.isFalse) {
      showRoundCloseBtn(true);
    }
    if (searchedKeyword.isEmpty && showRoundCloseBtn.isTrue) {
      showRoundCloseBtn(false);
    }
  }

  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
    showRoundCloseBtn(false);

    switch (currentPageViewIndex) {
      case 0:
        selectedContentId(0);
        break;
      case 1:
        isEnteredVideoUrlValid(ValidationState.initState);
        break;
    }
  }


  @override
  void onInit() {
    super.onInit();

    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });

    pageViewController = PageController();
    focusNode = FocusNode();
  }
}
