import 'package:soon_sak/utilities/index.dart';


class SearchPagedContentImpl
    with SearchHandlerMixin, PagingHandlerMixin
    implements SearchPagedContentUseCase {
  SearchPagedContentImpl(this._repository);

  final TmdbRepository _repository;
  final Rxn<Content> _selectedContent = Rxn();

  @override
  String get searchedKeyword => term;

  @override
  TmdbRepository get repository => _repository;

  @override
  Content? get selectedContent => _selectedContent.value;
  Timer? _debounce;

  @override
  bool get isPagingAllowed => getPagingAvailableState(term);

  /* Intents */
  // 검색어가 입력되었을 때
  @override
  Future<void> onSearchTermEntered() async {
    toggleCloseBtn();
    if (isPagingAllowed) {
      // Debounce delay 설정
      if (_debounce?.isActive ?? false) _debounce!.cancel();
      _debounce =
          Timer(const Duration(milliseconds: 300), pagingController.refresh);
      _selectedContent.value = null;
    }
  }

  // 검색된 컨텐츠가 선택 되었을 때
  @override
  void onSearchedContentTapped(
      {required SearchedContent content, required ContentType contentType}) {
    _selectedContent.value = Content(
      id: content.contentId,
      type: contentType,
      detail: ContentDetail(
        title: content.title,
        posterImgUrl: content.posterImgUrl,
        releaseDate: content.releaseDate,
      ),
    );
  }
}
