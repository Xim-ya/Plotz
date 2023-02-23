import 'dart:developer';

import 'package:soon_sak/domain/model/content/search/search_content_model.dart';
import 'package:soon_sak/utilities/index.dart';

class NewSearchedPagedContentUseCase with SearchHandlerMixin {
  NewSearchedPagedContentUseCase(this._tmdbRepository);

  /* Variables */
  final Rx<ContentType> selectedTabType = Rx(ContentType.tv);
  final int _pageSize = 20;
  final RxBool isInitialState = true.obs;

  /* Data Modules */
  final TmdbRepository _tmdbRepository;

  /* Controllers */
  Timer? _debounce;

  FocusNode get focusNode => fieldNode;
  final PagingController<int, SearchedContent> pagingController =
      PagingController(firstPageKey: 1);

  RxBool get showRoundClosedBtn => exposeRoundCloseBtn;

  TextEditingController get textEditingController => fieldController;

  @override
  void onSearchTermEntered() {
    toggleCloseBtn();
    if (isInitialState.isTrue) isInitialState(false);
    if (fieldController.text == '') isInitialState(true);

    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(
        const Duration(milliseconds: 300),
        () => {
              pagingController.refresh(),
            });
  }

  Future<void> fetchPage(int pageKey) async {
    if (fieldController.text.isEmpty) {
      pagingController.appendLastPage([]);
      return;
    }

    Result<SearchContentModel> response;

    if (selectedTabType.value.isTv) {
      response = await _tmdbRepository.loadSearchedTvContentList(
          query: fieldController.text, page: pageKey);
    } else {
      response = await _tmdbRepository.loadSearchedMovieContentList(
          query: fieldController.text, page: pageKey);
    }

    final PagingController<int, SearchedContent> controller = pagingController;

    response.fold(onSuccess: (data) {
      final searchedContents = data.contents;
      final isLastPage = searchedContents.length < _pageSize;
      if (isLastPage) {
        log('LAST PAGE CALLED');
        print('aim ${searchedContents.length}');
        controller.appendLastPage(searchedContents);
      } else {
        log('FIRST PAGE CALLED');
        final nextPageKey = pageKey + 1;
        controller.appendPage(searchedContents, nextPageKey);
      }
    }, onFailure: (e) {
      print(e);
      controller.error = e;
    });
  }

  void initUseCase() {
    pagingController.addPageRequestListener(fetchPage);
  }
}
