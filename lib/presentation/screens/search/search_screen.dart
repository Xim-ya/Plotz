import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/search/searched_content.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchScreen extends BaseScreen<SearchViewModel> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return PagingSearchedResultListView(
      focusNode: vm(context).focusNode,
      isInitialState: vm(context).isInitialState,
      pagingController: vm(context).pagingController,
      firstPageErrorText: '콘텐츠를 검색해 주세요',
      itemBuilder: (BuildContext context, dynamic item, int index) {
        final searchedItem = item as SearchedContentNew;
        return KeepAliveView(
          child: SearchListItem(
            contentType: MediaType.tv,
            item: searchedItem,
            onItemClicked: () {
              vm(context).onSearchedContentTapped(
                content: searchedItem,
              );
            },
          ),
        );
      },
    );
  }

  // 앱바 - 검색 컨테이너
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(0, 100),
      child: Container(
        padding: AppInset.horizontal12,
        margin: EdgeInsets.only(
            top: SizeConfig.to.statusBarHeight + 12, bottom: 16),
        height: 36,
        child: Selector<SearchViewModel, bool>(
          selector: (context, vm) => vm.showRoundCloseBtn,
          builder: (context, showRoundCloseBtn, _) {
            return AppSearchBar(
              focusNode: vm(context).focusNode,
              textEditingController: vm(context).textEditingController,
              onChanged: (_) {
                vm(context).onTextChanged();
              },
              resetSearchValue: vm(context).onClosedBtnTapped,
              showRoundCloseBtn: showRoundCloseBtn,
              width: SizeConfig.to.screenWidth - 88,
              // width: SizeConfig.to.screenWidth - 84,
            );
          },
        ),
      ),
    );
  }

  @override
  SearchViewModel createViewModel(BuildContext context) =>
      locator<SearchViewModel>();
}
