import 'package:soon_sak/utilities/index.dart';

class SearchContentPageView extends BaseView<RegisterViewModel> {
  const SearchContentPageView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return SearchContentPageViewScaffold(
      header: _buildHeader(),
      searchBar: _buildSearchBar(),
      searchedListView: _buildSearchedListView(),
      bottomFixedStepBtn: _buildBottomFixedStepBtn(),
    );
  }

  // 헤더
  Widget _buildHeader() => Padding(
        padding: AppInset.top10 + AppInset.bottom16,
        child: Text(
          '${vm.selectedContentType.asText}\n제목을 검색해주세요',
          style: AppTextStyle.headline1,
        ),
      );

  // 검색창
  Widget _buildSearchBar() => SearchBar(
        focusNode: vm.contentFormFocusNode,
        textEditingController: vm.textEditingController,
        onChanged: (_) {
          vm.onSearchTermEntered();
        },
        resetSearchValue: vm.onCloseBtnTapped,
        showRoundCloseBtn: vm.showContentSbCloseBtn,
      );

  // 검색 결과 리스트
  Widget _buildSearchedListView() => PagingResultListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: AppInset.top4 + AppInset.bottom104,
        focusNode: vm.contentFormFocusNode,
        pagingController: vm.pagingController,
        isInitialState: vm.isInitialState,
        firstPageErrorText: '영화 제목을 입력해주세요',
        itemBuilder: (BuildContext context, dynamic item, int index) {
          final searchedItem = item as SearchedContent;
          return Obx(
            () => SearchedContentItemBtn(
              onBtnTap: () {
                vm.onSearchedContentTapped(item);
              },
              title: searchedItem.title,
              posterImgUrl: searchedItem.posterImgUrl,
              releaseDate: searchedItem.releaseDate,
              contentType: vm.selectedContentType,
              isSelected: vm.selectedContentId == item.contentId,
            ),
          );
        },
      );

  // 하단 고정 버튼
  Widget _buildBottomFixedStepBtn() => Obx(
        () => AnimatedOpacity(
          opacity: vm.isContentSelected.value ? 1 : 0,
          duration: const Duration(milliseconds: 500),
          child: Visibility(
            visible: vm.isContentSelected.value ? true : false,
            child: Stack(
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: 72,
                    width: SizeConfig.to.screenWidth,
                    color: AppColor.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      bottom: SizeConfig.to.responsiveBottomInset),
                  child: LinearBgBottomFloatingBtn(
                    text: '다음',
                    onTap: vm.onFloatingStepBtnTapped,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
