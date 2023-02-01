part of '../register_view_model.dart';

extension FindContentViewModel on RegisterViewModel {
  /* Intent */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    await _pagingHandler.loadSearchedContentList(selectedContentType,
        checkContentRegistration: true);
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
  void onSearchedContentTapped(SearchedContent content) {
    selectedContentId.value = content.contentId;
    qurationContent = Content(
      id: content.contentId,
      type: selectedContentType,
      detail: ContentDetail(
        title: content.title,
        posterImgUrl: content.posterImgUrl,
        releaseDate: content.releaseDate,
      ),
    );
  }

  void onCloseBtnTapped() {
    _pagingHandler.onCloseBtnTapped();
  }

  RxBool get showCloseBtn1 => _pagingHandler.showRoundCloseBtn;

  RxBool get show1StepFloatingBtn => (selectedContentId.value != 0).obs;

  TextEditingController get textEditingController =>
      _pagingHandler.textEditingController;

  PagingController<int, SearchedContent> get pagingController =>
      _pagingHandler.pagingController;

  FocusNode get contentFormFocusNode => _pagingHandler.focusNode;
}
