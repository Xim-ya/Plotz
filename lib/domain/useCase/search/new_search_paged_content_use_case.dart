import 'dart:developer';

import 'package:soon_sak/domain/model/content/search/search_content_model.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya -2023.02.23
 * Paging이 적용되어 있는 검색 결과 호출 usecase
 * [SearchHandlerMxin] 모듈을 결합되어 있는 형태
 * [PagingSearchHandlerMixin]을 따로 만들어 사용했었지만,
 * 오히려 유지보수성과 가독을 고려하지 못해서 paging 관련 리소스는 해당
 * usecase 모둘에서 사용함.
 * TODO : 좀 더 고민이 필요
 *
 * */

class NewSearchedPagedContentUseCase with SearchHandlerMixin {
  NewSearchedPagedContentUseCase({required TmdbRepository tmdbRepository})
      : _tmdbRepository = tmdbRepository;

  /* Variables */
  ContentType selectedTabType = ContentType.tv; // 선택된 탭
  final int _pageSize = 2; // 최대 호출 가능한 페이지 사이즈
  int currentPage = 1;
  final int maxContentLength = 10;
  bool isInitialState = true; // 검색 이벤트가 일어나기 초기 상태
  bool get showRoundClosedBtn => exposeRoundCloseBtn; // 검색타 'X' 버튼 노출여부
  TextEditingController get textEditingController =>
      fieldController; // 검색 필드 컨트롤러

  /* Data Modules */
  final TmdbRepository _tmdbRepository;

  /* Controllers */
  Timer? _debounce;

  FocusNode get focusNode => fieldNode;
  final PagingController<int, SearchedContent> pagingController =
      PagingController(firstPageKey: 1);

  /* Intents */
  VoidCallback get resetFieldValue => onCloseBtnTapped;

  // 검색어가 입력되었을 때
  @override
  void onSearchTermEntered() {
    // 'X' 버튼 토글 로직
    toggleCloseBtn();

    // 초기 상태 설정 로직
    if (isInitialState == true) isInitialState = false;
    if (fieldController.text == '') isInitialState = true;

    // 검색어 Debounce 설정 0.3초
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
      const Duration(milliseconds: 450),
      () => {
        pagingController.refresh(),
      },
    );
  }

  // Paging Call 메소드
  Future<void> fetchPage(int pageKey, {ContentType? forcedContentType}) async {
    /// 처음 pagingController listen 할 때는
    /// paging call 하지 않기 위해 예외처리 진행
    if (fieldController.text.isEmpty) {
      pagingController.appendLastPage([]);
      return;
    }

    Result<SearchContentModel> response;

    /// 선택된 [ConteType] 에 따라 api call을 진행
    /// Movie & TV

    // 조건 : Viewmodel로부터 전달 받은 타입이 있을 경우
    // TODO : 조건문 리팩토링 필요
    if (forcedContentType.hasData) {
      if (forcedContentType!.isTv) {
        response = await _tmdbRepository.loadSearchedTvContentList(
          query: fieldController.text,
          page: pageKey,
        );
      } else {
        response = await _tmdbRepository.loadSearchedMovieContentList(
          query: fieldController.text,
          page: pageKey,
        );
      }
    } else {
      if (selectedTabType.isTv) {
        response = await _tmdbRepository.loadSearchedTvContentList(
          query: fieldController.text,
          page: pageKey,
        );
      } else {
        response = await _tmdbRepository.loadSearchedMovieContentList(
          query: fieldController.text,
          page: pageKey,
        );
      }
    }

    final PagingController<int, SearchedContent> controller = pagingController;

    response.fold(
      onSuccess: (data) {
        final searchedContents = data.contents;

        /// TMDB Search API 기준
        /// Response 20개가 넘지 않으면 다음 page가 없다고 판단
        /// 이때 [appedLastPage]를 적용하여 마지막 page call 로직을 적용
        final isLastPage = data.contents.length < 20;
        if (isLastPage) {
          log('LAST PAGE CALLED');
          controller.appendLastPage(searchedContents);
        } else {
          log('FIRST PAGE CALLED');
          currentPage = data.page + 1;
          controller.appendPage(searchedContents, data.page);
        }
      },
      onFailure: (e) {
        controller.error = e;
      },
    );
  }

  /// UseCase init메소드
  /// pagingController event listen 설정
  void initUseCase({ContentType? forcedContentType}) {
    pagingController.addPageRequestListener((_) {
      fetchPage(currentPage, forcedContentType: forcedContentType);
    });
  }

  /// UseCase에서 사용하는 컨트롤러 Dispose
  void disposeUseCase() {
    textEditingController.dispose();
    pagingController.dispose();
    focusNode.dispose();
  }
}
