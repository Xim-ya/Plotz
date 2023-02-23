import 'package:soon_sak/utilities/index.dart';

class SearchScreen extends BaseScreen<SearchViewModel> {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return SearchScaffold(
      tabs: buildTabs(),
      tabViews: buildTabView(),
    );
  }

  List<Widget> buildTabView() => [
        PagingResultListView(
          focusNode: vm.focusNode,
          isInitialState: vm.isInitialState,
          pagingController: vm.pagingController,
          firstPageErrorText: '드라마 제목을 입력해주세요',
          itemBuilder: (BuildContext context, dynamic item, int index) {
            final searchedItem = item as SearchedContent;
            return SearchListItem(
              contentType: ContentType.tv,
              item: searchedItem,
              onItemClicked: () {
                vm.onSearchedContentTapped(
                    content: searchedItem, contentType: ContentType.tv);
              },
            );
          },
        ),
        PagingResultListView(
          focusNode: vm.focusNode,
          isInitialState: vm.isInitialState,
          pagingController: vm.pagingController,
          firstPageErrorText: '영화 제목을 입력해주세요',
          itemBuilder: (BuildContext context, dynamic item, int index) {
            final searchedItem = item as SearchedContent;
            return SearchListItem(
              contentType: ContentType.movie,
              item: searchedItem,
              onItemClicked: () {
                vm.onSearchedContentTapped(
                  content: searchedItem,
                  contentType: ContentType.movie,
                );
              },
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
            SearchBar(
              focusNode: vm.focusNode,
              textEditingController: vm.textEditingController,
              onChanged: (_) {
                vm.onTextChanged();
              },
              resetSearchValue: vm.onClosedBtnTapped,
              showRoundCloseBtn: vm.showRoundCloseBtn,
              width: SizeConfig.to.screenWidth - 84,
            ),
            MaterialButton(
              minWidth: 40,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              onPressed: Get.back,
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

// // [TextField] OutLinedBorder 속성
// OutlineInputBorder _fixedOutLinedBorder() {
//   return const OutlineInputBorder(
//       borderRadius: BorderRadius.all(Radius.circular(6)),
//       borderSide: BorderSide(color: Colors.transparent));
// }
}
