import 'package:uppercut_fantube/presentation/common/listView/paging_result_list_view.dart';
import 'package:uppercut_fantube/presentation/screens/search/localWidget/searched_list_item.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.12.24 🎅
 * [SearchScreen] > TabView에서 사용되는
 *  페이징 리스트 뷰
 *  인자 전달 받은 [ContentType]에 따라 일부 요소를 분기처리.
 * */

class SearchedResultPagedListView extends BaseView<SearchViewModel> {
  const SearchedResultPagedListView({Key? key, required this.contentType})
      : super(key: key);

  final ContentType contentType;

  @override
  Widget buildView(BuildContext context) {
    return PagingResultListView(
      focusNode: vm.focusNode,
      pagingController: vm.pagingController,
      firstPageErrorText: '드라마 제목을 입력해주세요',
      itemBuilder: (BuildContext context, dynamic item, int index) {
        final searchedItem = item as SearchedContent;
        return SearchedListItem(
          contentType: contentType,
          item: searchedItem,
          onItemClicked: () {
            vm.onSearchedContentTapped(
                content: searchedItem, contentType: contentType);
          },
        );
      },
    );
  }
}
