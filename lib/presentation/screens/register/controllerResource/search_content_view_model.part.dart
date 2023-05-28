part of '../register_view_model.dart';

extension FindContentViewModel on RegisterViewModel {
  /* Intent */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  // Future<void> loadSearchedContentListByPaging() async {
  //   await _searchUseCase.loadSearchedContentList(selectedContentType,
  //       checkContentRegistration: true);
  // }

  // 검색어가 입력되었을 때
  VoidCallback get onSearchTermEntered =>
      pagedSearchHandler.onSearchTermEntered;

  // 검색된 컨텐츠 선택 되었을 때
  void onSearchedContentTapped(SearchedContent content) {
    _selectedContent = Content(
      id: content.contentId,
      type: selectedContentType,
      detail: ContentDetail(
        title: content.title,
        posterImgUrl: content.posterImgUrl,
        releaseDate: content.releaseDate,
      ),
    );

    notifyListeners();
  }

  // 검색 바 'X' 버튼이 클릭 되었을 때
  void onCloseBtnTapped() {
    pagedSearchHandler.onCloseBtnTapped();
  }


  bool get isContentSelected => _selectedContent.hasData;

  TextEditingController get textEditingController =>
      pagedSearchHandler.textEditingController;

  PagingController<int, SearchedContent> get pagingController =>
      pagedSearchHandler.pagingController;

  FocusNode get contentFormFocusNode => pagedSearchHandler.focusNode;

  int? get selectedContentId => _selectedContent?.id;

  bool get isInitialState => pagedSearchHandler.isInitialState;

// Content? get selectedContentDetail => _searchUseCase.selectedContent;
}
