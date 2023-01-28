import 'package:uppercut_fantube/presentation/common/listView/paging_result_list_view.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/search/localWidget/searched_list_item.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class FindContentView extends BaseView<RegisterViewModel> {
  const FindContentView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Padding(
      padding: AppInset.horizontal16,
      child: Column(
        children: <Widget>[
          AppSpace.size10,
          // 검색 창
          SearchBar(
            focusNode: vm.focusNode,
            textEditingController: vm.textEditingController,
            onChanged: (String input) {},
            onFieldSubmitted: (String result) {},
            resetSearchValue: vm.resetSearchValue,
            showRoundCloseBtn: vm.showRoundCloseBtn,
          ),

          // 검색 결과 리스트

          PagingResultListView(
            focusNode: vm.focusNode,
            pagingController: vm.pagingController,
            firstPageErrorText: '영화 제목을 입력해주세요',
            itemBuilder: (BuildContext context, dynamic item, int index) {
              final searchedItem = item as SearchedContent;

              return Text(searchedItem.title ?? '제목 없음',
                  style: AppTextStyle.title1);

              return SearchedListItem(
                contentType: ContentType.movie,
                item: searchedItem,
                onItemClicked: () {},
              );
            },
          ),
        ],
      ),
    );
  }
}
