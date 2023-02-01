part of '../register_view_model.dart';

extension FindContentViewModel on RegisterViewModel {
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

  //  검색 바 'x' 버튼 노출 여부 로직
  void toggleSearchBarClosedBtn() {
    if (searchedKeyword.isNotEmpty &&
        _pagingHandler.showRoundCloseBtn.isFalse) {
      _pagingHandler.showRoundCloseBtn(true);
    }
    if (searchedKeyword.isEmpty && _pagingHandler.showRoundCloseBtn.isTrue) {
      _pagingHandler.showRoundCloseBtn(false);
    }
  }

  // 검색어가 입력되었을 때
  void onSearchChanged(String searchedKeyword) {
    toggleSearchBarClosedBtn();

    if (_pagingHandler.isPagingAllowed) {
      // Debounce delay 설정
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce =
          Timer(const Duration(milliseconds: 300), pagingController.refresh);
      selectedContentId(0);
    }
  }

  // 검색된 컨텐츠 선택 되었을 때
  void onSearchedContentTapped(int contentId) {
    selectedContentId.value = contentId;
  }

  void onCloseBtnTapped() {
    _pagingHandler.onCloseBtnTapped();
  }

  RxBool get showCloseBtn1 => _pagingHandler.showRoundCloseBtn;

  // 하단 고정 버튼 활성화 여부
  RxBool get show1StepFloatingBtn => (selectedContentId.value != 0).obs;
}
