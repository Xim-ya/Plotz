import 'package:uppercut_fantube/presentation/common/listView/paging_result_list_view.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/localWidget/searched_content_item_btn.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
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
            onChanged: vm.onSearchChanged,
            onFieldSubmitted: (_) {
              vm.loadSearchedContentListByPaging();
            },
            resetSearchValue: vm.resetSearchValue,
            showRoundCloseBtn: vm.showRoundCloseBtn,
          ),

          AppSpace.size8,


          // 검색 결과 리스트

          Expanded(
            child: PagingResultListView(
              padding:  AppInset.top20 + AppInset.bottom46,
              focusNode: vm.focusNode,
              pagingController: vm.pagingController,
              firstPageErrorText: '영화 제목을 입력해주세요',
              itemBuilder: (BuildContext context, dynamic item, int index) {
                final searchedItem = item as SearchedContent;
                return SearchedContentItemBtn(
                  title: searchedItem.title,
                  posterImgUrl: searchedItem.posterImgUrl,
                  releaseDate: searchedItem.releaseDate,
                  contentType: vm.selectedContentType,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
