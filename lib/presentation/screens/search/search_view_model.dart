import 'dart:async';
import 'dart:developer';
import 'package:uppercut_fantube/utilities/index.dart';

/// TODO: PAGING 고도화 로직 필요
/// Tabview를  제스처로 이동할 때 UX가 부자연스러움.
/// PAGING Controller를 두 개로 분리 필요. (메모리를 너무 많이 사용하는지 사전에 확인 필요)

class SearchViewModel extends BaseViewModel {
  SearchViewModel(this._loadSearchedContentResult);

  /* State Variables */
  // 검색 앱바 'x' 버튼 노출여부
  RxBool showRoundCloseBtn = false.obs;

  /* Controllers */
  late TextEditingController textEditingController; // 검색 TextField Controller
  late final PagingController<int, SearchedContent>
      pagingController; // 'tv' Paging Controller(검색 결과)

  Timer? _debounce; // 검색 api call 시간 딜레이

  /* UseCases */
  final LoadSearchedContentResultUseCase _loadSearchedContentResult;

  /* Intents */

  /// 검색된 컨텐츠 클릭 되었을 때
  /// 컨텐츠 등록 여부에 따라 다른 동작(1,2,3)을 실행
  void onSearchedContentTapped(
      {required SearchedContent content, required ContentType contentType}) {
    final registeredValue = content.isRegisteredContent.value;
    // 1. isRegistered 데이터가 로그 안되었다면 toast 메세지를 띄움
    if (registeredValue == ContentRegisteredValue.isLoading) {
      AlertWidget.toast('잠시만 기다려주세요. 데이터를 로딩하고 있습니다');
      return;
    }

    // 2. 등록된 컨텐츠라면 상세 페이지로 이동
    if (registeredValue == ContentRegisteredValue.registered) {
      Get.toNamed(
        AppRoutes.contentDetail,
        arguments: ContentArgumentFormat(
            contentId: content.contentId,
            contentType: contentType,
            posterImgUrl: content.posterImgUrl!,
            videoId: content.youtubeVideoId!),
      );
      return;
    } else {
      // TODO: 3. 등록된 컨텐츠가 아니라면 유저에게 '요청해주세요' 다이어로그를 띄움.
      return;
    }
  }

  // 검색어 초기화 - 'X' 버튼이 클릭 되었을 때
  void resetSearchValue() {
    textEditingController.text = '';
    showRoundCloseBtn(false);
  }

  /// 검색어가 입력창에 입력되었을 때 (Debounce 설정 0.3초)
  /// 특정 조건(1,2,3,4,)에서는 검색 메소드를 실행하지 않음.
  /// 위 특정 조건이 아니라면 pagingController를 refresh하여 검색 api call 실행
  void onSearchChanged(String query) {
    // AppBar 검색창 'x' 버튼 노출 여부
    if (textEditingController.text.isNotEmpty) {
      if (showRoundCloseBtn.isFalse) showRoundCloseBtn(true);
    } else {
      if (showRoundCloseBtn.isTrue) showRoundCloseBtn(false);
    }

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
    _debounce =
        Timer(const Duration(milliseconds: 300), pagingController.refresh);
  }

  /* Networking Method */
  // 컨텐츠 리스트 호출 - (pagination logic 적용)
  Future<void> loadSearchedContentListByPaging() async {
    if (loading.isTrue) {
      return;
    }
    loading(true);

    // 입력된 검색어가 없다면 api call을 하지 않음.

    final responseResult = await _loadSearchedContentResult(
      SearchScaffoldController.selectedTabType,
      textEditingController.text,
    );

    /// 최대 불러올 수 있는 page 넘버를 2로 설정 (컨텐츠 40개) - TMDB 기준
    /// 호출한 데이터가 20개 이하면 더 이상 불러올 수 없다고 판단하고 더 이상 listen 하지 않음
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
    loading(false);
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
const List<String> invalidCharacter = [
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
