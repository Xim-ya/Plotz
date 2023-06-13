import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchContentPageView extends BaseView<RegisterViewModel> {
  const SearchContentPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SearchContentPageViewScaffold(
      header: _buildHeader(context),
      searchBar: const _SearchBar(),
      searchedListView: const _SearchedList(),
      bottomFixedStepBtn: const _BottomFixedBtn(),
    );
  }

  // 헤더
  Widget _buildHeader(BuildContext context) => Padding(
        padding: AppInset.top10 + AppInset.bottom16,
        child: Text(
          '${vm(context).selectedContentType.asText}\n제목을 검색해주세요',
          style: AppTextStyle.headline1,
        ),
      );



}

//검색창
class _SearchBar extends BaseView<RegisterViewModel> {
  const _SearchBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewModel, bool>(
        selector: (context, vm) => vm.showContentFormCloseBtn,
        builder: (context, showRoundCloseBtn, _) => AppSearchBar(
            focusNode: vm(context).contentFormFocusNode,
            textEditingController: vm(context).textEditingController,
            onChanged: (_) {
              vm(context).onSearchTermEntered();
            },
            resetSearchValue: vm(context).onCloseBtnTapped,
            showRoundCloseBtn: showRoundCloseBtn));
  }
}

// 하단 고정 버튼
class _BottomFixedBtn extends BaseView<RegisterViewModel> {
  const _BottomFixedBtn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewModel, bool>(
        selector: (context, vm) => vm.isContentSelected,
        builder: (context, isSelected, _) {
          return AnimatedOpacity(
            opacity: isSelected ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: isSelected ? true : false,
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
                      bottom: SizeConfig.to.responsiveBottomInset,
                    ),
                    child: LinearBgBottomFloatingBtn(
                      text: '다음',
                      onTap: vm(context).onFloatingStepBtnTapped,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

// 검색 결과 리스트
class _SearchedList extends BaseView<RegisterViewModel> {
  const _SearchedList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterViewModel>(builder: (context, vm, _) {
      return PagingSearchedResultListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: AppInset.top4 + AppInset.bottom104,
        focusNode: vm.contentFormFocusNode,
        pagingController: vm.pagingController,
        isInitialState: vm.isInitialState,
        firstPageErrorText: '영화 제목을 입력해주세요',
        itemBuilder: (BuildContext _, dynamic item, int index) {
          final searchedItem = item as SearchedContent;
          return SearchedContentItemBtn(
            onBtnTap: () {
              vm.onSearchedContentTapped(item);
            },
            title: searchedItem.title,
            posterImgUrl: searchedItem.posterImgUrl,
            releaseDate: searchedItem.releaseDate,
            contentType: vm.selectedContentType,
            isSelected: vm.selectedContentId == item.contentId,
          );
        },
      );
    });
  }
}
