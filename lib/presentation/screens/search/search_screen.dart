import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchScreen extends BaseScreen<SearchViewModel> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return SearchScaffold(
      tabs: buildTabs(),
      tabViews: buildTabView(context),
    );
  }

  List<Widget> buildTabView(BuildContext context) => [
        PagingSearchedResultListView(
          focusNode: vm(context).focusNode,
          isInitialState: vm(context).isInitialState,
          pagingController: vm(context).pagingController,
          firstPageErrorText: '드라마 제목을 입력해주세요',
          itemBuilder: (BuildContext context, dynamic item, int index) {
            final searchedItem = item as SearchedContent;
            return KeepAliveView(
              child: SearchListItem(
                contentType: ContentType.tv,
                item: searchedItem,
                onItemClicked: () {
                  vm(context).onSearchedContentTapped(
                    content: searchedItem,
                    contentType: ContentType.tv,
                  );
                },
              ),
            );
          },
        ),
        PagingSearchedResultListView(
          focusNode: vm(context).focusNode,
          isInitialState: vm(context).isInitialState,
          pagingController: vm(context).pagingController,
          firstPageErrorText: '영화 제목을 입력해주세요',
          itemBuilder: (BuildContext context, dynamic item, int index) {
            final searchedItem = item as SearchedContent;
            return KeepAliveView(
              child: SearchListItem(
                contentType: ContentType.movie,
                item: searchedItem,
                onItemClicked: () {
                  vm(context).onSearchedContentTapped(
                    content: searchedItem,
                    contentType: ContentType.movie,
                  );
                },
              ),
            );
          },
        ),
      ];

  List<Tab> buildTabs() => const [
        Tab(text: '드라마', height: 42),
        Tab(text: '영화', height: 42),
      ];

  // 앱바 - 검색 컨테이너
  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size(0, 100),
      child: Container(
        padding: AppInset.horizontal12,
        margin: EdgeInsets.only(top: SizeConfig.to.statusBarHeight + 12),
        height: 40,
        child: Row(
          children: [
            Selector<SearchViewModel, bool>(
              selector: (context, vm) => vm.showRoundCloseBtn,
              builder: (context, showRoundCloseBtn, _) {
                return SearchBar(
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
            MaterialButton(
              minWidth: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: () {
                vm(context).routeBack(context);
              },
              child: Center(
                child: Text(
                  '취소',
                  style: AppTextStyle.title2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  SearchViewModel createViewModel(BuildContext context) =>
      locator<SearchViewModel>();


}
