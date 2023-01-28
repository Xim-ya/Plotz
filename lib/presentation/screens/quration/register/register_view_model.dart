import 'dart:async';
import 'package:uppercut_fantube/utilities/index.dart';

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

  /* Controllers */
  late PageController pageViewController;

  late FocusNode focusNode;

  TextEditingController get textEditingController =>
      _pagingHandler.textEditingController;

  PagingController<int, SearchedContent> get pagingController =>
      _pagingHandler.pagingController;

  /* UseCases */
  final PagingHandlerUseCase _pagingHandler;

  /* Intent */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    if (loading.isTrue) {
      return;
    }
    loading(true);
    await _pagingHandler.loadSearchedContentList(selectedContentType,
        checkContentRegistration: true);
    loading(false);
  }


  // 검색어가 입력되었을 때
  void onSearchChanged(String searchedKeyword) {

    // 'x' 버튼 노출 여부 로직
    if(searchedKeyword.isNotEmpty && showRoundCloseBtn.isFalse) {
      showRoundCloseBtn(true);
    }

    if(searchedKeyword.isEmpty && showRoundCloseBtn.isTrue) {
      showRoundCloseBtn(false);
    }

    if (_pagingHandler.isPagingAllowed) {
      // Paging Controller 리셋 --> 검색 api call 실행
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce =
          Timer(const Duration(milliseconds: 300), pagingController.refresh);
    }
  }


  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
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
