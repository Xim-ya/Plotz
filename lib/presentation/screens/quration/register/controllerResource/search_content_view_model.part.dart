part of '../register_view_model.dart';

extension FindContentViewModel on RegisterViewModel {
  /* Intent */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    await _searchUseCase.loadSearchedContentList(selectedContentType,
        checkContentRegistration: true);
  }

  // 검색어가 입력되었을 때
  void onSearchTermEntered(String searchedKeyword) {
    _searchUseCase.onSearchTermEntered();
  }

  // 검색된 컨텐츠 선택 되었을 때
  void onSearchedContentTapped(SearchedContent content) {
    _searchUseCase.onSearchedContentTapped(
        content: content, contentType: selectedContentType);
  }

  void onCloseBtnTapped() {
    _searchUseCase.onCloseBtnTapped();
  }

  RxBool get showContentSbCloseBtn => _searchUseCase.showRoundCloseBtn;
  RxBool get isContentSelected => (_searchUseCase.selectedContent.hasData).obs;
  TextEditingController get textEditingController =>
      _searchUseCase.textEditingController;
  PagingController<int, SearchedContent> get pagingController =>
      _searchUseCase.pagingController;
  FocusNode get contentFormFocusNode => _searchUseCase.focusNode;
  Content? get selectedContent => _searchUseCase.selectedContent;
}
