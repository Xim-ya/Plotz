import 'package:uppercut_fantube/domain/model/content/content.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.02.01
 *  검색 기능을 수행하는 UseCase
 *  해당 UseCase 아래와 같은 기능을 포함함
 *  1) 페이징 데이터
 *     반환 받는 페이징 데이터는 [SearchedContent] 타입으로 전제로 함
 *  2) 검색 Api 호출
 *  3) 검색바 'x' 닫기 버튼 로직
 *  4) 가상 키보드 인터렉션로직 (focusNode)
 *  5) 검색된 컨텐츠 선택 토글 로직
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
      {required SearchedContent content,required ContentType contentType});

  void onCloseBtnTapped();
}
