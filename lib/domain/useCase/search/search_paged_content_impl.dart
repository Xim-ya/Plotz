import 'dart:developer';
import 'package:uppercut_fantube/domain/mixin/search_handler_mixin.dart';
import 'package:uppercut_fantube/domain/model/content/content.dart';
import 'package:uppercut_fantube/domain/useCase/search/search_paged_content_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchPagedContentImpl
    with SearchHandlerMixin
    implements SearchPagedContentUseCase {
  SearchPagedContentImpl(this._repository);

  final TmdbRepository _repository;
  final PagingController<int, SearchedContent> _pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);
  final Rxn<Content> _selectedContent = Rxn();

  @override
  PagingController<int, SearchedContent> get pagingController =>
      _pagingController;

  @override
  Content? get selectedContent => _selectedContent.value;

  Timer? _debounce;

  // 검색 결과 paging(request)동작 시행 여부를 판별하는 메소드
  /// 특정 조건(1,2,3,4)에서는 'false' 값을 리턴하여 paging발동을 막음
  bool get isPagingAllowed {
    // 1. 입력된 검색어가 없다면 검색 X
    if (term.isEmpty || term == '') {
      return false;
    }

    // 2. 검색어 마지막 글자가 ' ' (공백)이라면 검색 X
    if (term.isNotEmpty && term.getLastCharacter == ' ') {
      return false;
    }

    // 3. 검색어에 검색 불가능한 특수문자가 포함되어 있다면 검색 X
    if (invalidSearchCharacter.contains(term)) {
      return false;
    }

    // 4. IOS space (공백) 연타시 '.'이 입력되는 현상이 있따면 검색 X
    if (term.getLastCharacter == '' &&
        term.contains(' ')) {
      return false;
    }

    return true;
  }

  // [Paging] - 다음 페이지 키. null 일 경우 0을 러틴.
  int get pagingNextPageKey {
    if (_pagingController.nextPageKey.hasData) {
      return _pagingController.nextPageKey! + 1;
    } else {
      return 0;
    }
  }

  // [Paging]- 페이징 동작 제한 여부. 'nextPageKey'로 판별.
  bool get limitPagingByPageLimit {
    if (_pagingController.nextPageKey.hasData) {
      return _pagingController.nextPageKey! > 1;
    } else {
      return false;
    }
  }



  // 검색어가 입력되었을 때
  @override
  Future<void> onSearchTermEntered() async {
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



  /// 검색된 컨텐츠 리스트 호출
  /// paging 로직 적용
  @override
  Future<void> loadSearchedContentList(ContentType contentType,
      {required bool checkContentRegistration}) async {
    Result<List<SearchedContent>> responseResult;

    if (contentType.isTv) {
      responseResult =
          await _repository.loadSearchedTvContentList(term);
    } else {
      responseResult =
          await _repository.loadSearchedMovieContentList(term);
    }

    responseResult.fold(
      onSuccess: (data) {
        // 등록된 컨텐츠인지 판별
        if (checkContentRegistration) {
          for (var content in data) {
            content.checkIsContentRegistered(contentType: contentType);
          }
        }

        final bool noMoreReturn = data.length < 20;
        if (limitPagingByPageLimit || noMoreReturn) {
          log('[PAGING] LAST LOAD');
          _pagingController.appendLastPage(data);
        } else {
          log('[PAGING] FIRST LOAD');
          if (data.length < 20) {
            _pagingController.appendLastPage(data);
          } else {
            _pagingController.appendPage(data, pagingNextPageKey + 1);
          }
        }
      },
      onFailure: (err) {
        _pagingController.error = err;
      },
    );
  }





// // 검색창 'x' 버튼이 클릭 되었을 때
// @override
// void onCloseBtnTapped() {
//   textFormEditingController.text = '';
//   showRoundCloseButton(false);
// }
}
