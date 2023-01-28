import 'dart:developer';
import 'package:uppercut_fantube/utilities/index.dart';

class PagingHandlerUseCase {
  PagingHandlerUseCase(this._repository);

  final TmdbRepository _repository;
  final TextEditingController textEditingController = TextEditingController();
  final PagingController<int, SearchedContent> pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);


  String get searchedKeyword => textEditingController.value.text;


  // 검색 결과 paging(request)동작 시행 여부를 판별하는 메소드
  /// 특정 조건(1,2,3,4)에서는 'false' 값을 리턴하여 paging발동을 막음
  bool get isPagingAllowed {

    // 1. 입력된 검색어가 없다면 검색 X
    if (searchedKeyword.isEmpty || searchedKeyword == '') {
      return false;
    }

    // 2. 검색어 마지막 글자가 ' ' (공백)이라면 검색 X
    if (searchedKeyword.isNotEmpty && searchedKeyword.getLastCharacter == ' ') {
      return false;
    }

    // 3. 검색어에 검색 불가능한 특수문자가 포함되어 있다면 검색 X
    if (invalidSearchCharacter.contains(searchedKeyword)) {
      return false;
    }

    // 4. IOS space (공백) 연타시 '.'이 입력되는 현상이 있따면 검색 X
    if (searchedKeyword.getLastCharacter == '' && searchedKeyword.contains(' ')) {
      return false;
    }

    return true;
  }

  // [Paging] - 다음 페이지 키. null 일 경우 0을 러틴.
  int get pagingNextPageKey {
    if (pagingController.nextPageKey.hasData) {
      return pagingController.nextPageKey! + 1;
    } else {
      return 0;
    }
  }

  // [Paging]- 페이징 동작 제한 여부. 'nextPageKey'로 판별.
  bool get limitPagingByPageLimit {
    if (pagingController.nextPageKey.hasData) {
      return pagingController.nextPageKey! > 1;
    } else {
      return false;
    }
  }

  /// 검색된 컨텐츠 리스트 호출
  /// paging 로직 적용
  Future<void> loadSearchedContentList(ContentType contentType) async {
    Result<List<SearchedContent>> responseResult;

    if(contentType.isTv) {
      responseResult = await _repository.loadSearchedTvContentList(searchedKeyword);
    } else {
      responseResult = await _repository.loadSearchedMovieContentList(searchedKeyword);
    }

    responseResult.fold(
      onSuccess: (data) {
        // 등록된 컨텐츠인지 판별
        for (var content in data) {
          content.checkIsContentRegistered(
              contentType: SearchScaffoldController.selectedTabType);
        }
        final bool noMoreReturn = data.length < 20;
        if (limitPagingByPageLimit || noMoreReturn) {
          log('[PAGING] LAST LOAD');
          pagingController.appendLastPage(data);
        } else {
          log('[PAGING] FIRST LOAD');
          if (data.length < 20) {
            pagingController.appendLastPage(data);
          } else {
            pagingController.appendPage(data, pagingNextPageKey + 1);
          }
        }
      },
      onFailure: (err) {
        pagingController.error = err;
      },
    );
  }
}

