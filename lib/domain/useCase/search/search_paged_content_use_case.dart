import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.02.01
 *  검색 기능과 페이징 기능이 적용되어 있는 UseCase
 *  [SearchPagedContentImpl] 클래스가  해당 UseCase를 implements 함
 *  [SearchPagedContentImpl] 클래스는 [SearchHandlerMixin] [PagingHandlerMixin] 모듈이 mixin 되어 있음
 * */

abstract class SearchPagedContentUseCase {
  TextEditingController get textEditingController;

  PagingController<int, SearchedContent> get pagingController;

  Content? get selectedContent;

  RxBool get showRoundCloseBtn;

  FocusNode get focusNode;

  String get searchedKeyword;

  Future<void> loadSearchedContentList(ContentType contentType,
      {required bool checkContentRegistration});

  Future<void> onSearchTermEntered();

  void onSearchedContentTapped(
      {required SearchedContent content, required ContentType contentType});

  void onCloseBtnTapped();
}
