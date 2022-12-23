import 'dart:async';
import 'dart:developer';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uppercut_fantube/domain/model/content/searched_content.dart';
import 'package:uppercut_fantube/domain/useCase/tmdb/load_searched_content_result_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchViewModel extends BaseViewModel {
  SearchViewModel(this._loadSearchedContentResult);

  /* Data Variables */
  // final Rxn<List<SearchedContent>> _tvContentSearchedList = Rxn();

  /* Controllers */
  late TextEditingController textEditingController; // 검색 TextField Controller
  late final PagingController<int, SearchedContent>
      pagingController; // Paging Controller(검색 결과)
  Timer? _debounce;

  /* UseCases */
  final LoadSearchedContentResultUseCase _loadSearchedContentResult;

  /* Intents */
  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
  }

  // 검색어가 입력창에 입력되었을 때
  void onSearchChanged(String query) {
    pagingController.refresh();
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      loadSearchedContentListByPaging();
    });
  }

  /* Networking Method */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    // 입력된 검색어가 없다면 api call을 하지 않음.
    if (textEditingController.text.isEmpty &&
        textEditingController.text == '') {
      return;
    }
    final responseResult = await _loadSearchedContentResult(
      ContentType.tv,
      textEditingController.text,
    );
    responseResult.fold(
      onSuccess: (data) {
        // 최대 불러올 수 있는 page 넘버를 2로 설정 (컨텐츠 40개) - TMDB 기준
        // 호출한 데이터가 20개 이하면 더 이상 불러올 수 없다고 판단하고 더 이상 listen 하지 않음

        final bool noMoreReturn = data.length < 20;
        if (limitPagingByPageLimit || noMoreReturn) {
          log('[PAGING] LAST LOAD');
          pagingController.appendLastPage(data);
        } else {
          log('[PAGING] FIRST LOAD');
          pagingController.appendPage(data, pagingNextPageKey + 1);
        }
      },
      onFailure: (err) {
        pagingController.error = err;
      },
    );
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

  @override
  void onInit() {
    super.onInit();
    pagingController = PagingController(
        firstPageKey: 1, invisibleItemsThreshold: 1); // paging controller 생성
    // paging 컨트럴러 listener 설정
    textEditingController = TextEditingController();
    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });
  }
}
