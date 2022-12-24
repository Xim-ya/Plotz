import 'dart:async';
import 'dart:developer';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:uppercut_fantube/domain/model/content/searched_content.dart';
import 'package:uppercut_fantube/domain/service/content_service.dart';
import 'package:uppercut_fantube/domain/useCase/tmdb/load_searched_content_result_use_case.dart';
import 'package:uppercut_fantube/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:uppercut_fantube/utilities/extensions/get_last_character_of_string.extension.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchViewModel extends BaseViewModel {
  SearchViewModel(this._loadSearchedContentResult);

  /* Data Variables */
  // final Rxn<List<SearchedContent>> _tvContentSearchedList = Rxn();

  /* Controllers */
  late TextEditingController textEditingController; // 검색 TextField Controller
  late final PagingController<int, SearchedContent>
      pagingController; // 'tv' Paging Controller(검색 결과)

  Timer? _debounce;

  /* UseCases */
  final LoadSearchedContentResultUseCase _loadSearchedContentResult;

  /* Intents */
  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
  }

  /// 검색어가 입력창에 입력되었을 때 (Debounce 설정 0.3초)
  /// 특정 조건(1,2,3,4,)에서는 검색 메소드를 실행하지 않음.
  /// 위 특정 조건이 아니라면 pagingController를 refresh하여 검색 api call 실행
  void onSearchChanged(String query) {
    // 1. 입력된 검색어가 없다면 검색 X
    if (textEditingController.text.isEmpty ||
        textEditingController.text == '') {
      return;
    }

    // 2. 검색어 마지막 글자가 ' ' (공백)이라면 검색 X
    if (textEditingController.text.isNotEmpty &&
        textEditingController.text.getLastCharacter == ' ') {
      return;
    }

    // 3. 검색어에 검색 불가능한 특수문자가 포함되어 있다면 검색 X
    if (invalidCharacter.contains(textEditingController.text)) {
      return;
    }

    // 4. IOS space (공백) 연타시 '.'이 입력되는 현상이 있따면 검색 X
    if (textEditingController.text.getLastCharacter == '' &&
        textEditingController.text.contains(' ')) {
      return;
    }

    // Paging Controller 리셋 --> 검색 api call 실행
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 800), pagingController.refresh);
  }

  /* Networking Method */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    // 입력된 검색어가 없다면 api call을 하지 않음.

    final responseResult = await _loadSearchedContentResult(
      SearchScaffoldController.selectedTabType,
      textEditingController.text,
    );

    responseResult.fold(
      onSuccess: (data) {
        // 최대 불러올 수 있는 page 넘버를 2로 설정 (컨텐츠 40개) - TMDB 기준
        // 호출한 데이터가 20개 이하면 더 이상 불러올 수 없다고 판단하고 더 이상 listen 하지 않음

        // 등록된 컨텐츠인지 판별
        for (var content in data) {
          content.checkIsContentRegistered();
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

  // Paging Controller 리셋
  void refreshPagingController() {
    pagingController.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    // Paging 컨트롤러 생성 (tv,movie)
    pagingController = PagingController(
        firstPageKey: 1, invisibleItemsThreshold: 1); // paging controller 생성

    // paging 컨트롤러 listener 설정
    textEditingController = TextEditingController();
    pagingController.addPageRequestListener((pageKey) {
      loadSearchedContentListByPaging();
    });

    // 등록된 Movie & Tv 컨텐츠 정보 호출
    ContentService.to.fetchAllOfRegisteredTvContent();
  }

  /* Getters */

  // Paging Controller 리셋, 탭이 onChanged 되었을 때 발동.
  static SearchViewModel get to => Get.find();
}

// 검색어 입력이 불가능한 특수문자
List<String> invalidCharacter = [
  '. ',
  '.',
  '-',
  '/',
  ':',
  ';',
  '(',
  ')',
  '₩',
  '"',
  '\'',
  '[',
  ']',
  '{',
  '}',
  '<',
  '>',
  '£',
  '¥',
  '•',
  '\'',
  ','
];
