import 'dart:developer';
import 'package:soon_sak/domain/model/content/search/search_content_model.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 202.02.02
 *  검색 페이징 담고 있는 mixin 모듈
 *  해당 모듈은 아래의 기능과 리소스를 가지고 있음
 *  1) PagingController 리소스 [pagingController]
 *  2) Paging Api Call 로직 [loadSearchedContentList]
 *  3) Paging 실행 관련 유효성 검사 로직 [getPagingAvailableState]
 * */

mixin PagingSearchHandlerMixin {
  final PagingController<int, SearchedContent> pagingController =
      PagingController(firstPageKey: 1, invisibleItemsThreshold: 1);

  /// mixin 되는 클래스로 전달 받는 변수
  String get searchedKeyword;

  TmdbRepository get repository;

  bool get isPagingAllowed;

  final RxBool isInitialPageState = true.obs;

  /// 검색된 컨텐츠 리스트 호출
  /// paging 로직 적용
  Future<void> loadSearchedContentList(
    ContentType contentType, {
    required bool checkContentRegistration,
  }) async {
    Result<SearchContentModel> responseResult;

    /// pagingController가 Listen 되고
    /// 검색어가 없는 상태에서 Call하는 상태를 방지하기 위한 구문
    if (isInitialPageState.isTrue) {
      pagingController.appendPage([], 0);
      isInitialPageState(false);
      return;
    }

    responseResult =
        await repository.loadSearchedMovieContentList(query: '', page: 1);

    responseResult.fold(
      onSuccess: (data) {
        final bool noMoreReturn = data.contents.length < 20;
        if (limitPagingByPageLimit || noMoreReturn) {
          log('[PAGING] LAST LOAD');
          pagingController.appendLastPage(data.contents);
        } else {
          log('[PAGING] FIRST LOAD');
          if (data.contents.length < 20) {
            pagingController.appendLastPage(data.contents);
          } else {
            pagingController.appendPage(data.contents, pagingNextPageKey + 1);
          }
        }
      },
      onFailure: (err) {
        pagingController.error = err;
      },
    );
  }

  // 검색 결과 paging(request)동작 시행 여부를 판별하는 메소드
  /// 특정 조건(1,2,3,4)에서는 'false' 값을 리턴하여 paging발동을 막음
  bool getPagingAvailableState(String term) {
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
    if (term.getLastCharacter == ' ' && term.contains('.')) {
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
}
