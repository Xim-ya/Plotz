import 'package:uppercut_fantube/presentation/common/button/linear_background_bottom_floating_btn.dart';
import 'package:uppercut_fantube/presentation/common/listView/paging_result_list_view.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/localWidget/searched_content_item_btn.dart';
import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class FindContentView extends BaseView<RegisterViewModel> {
  const FindContentView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Padding(
          padding: AppInset.horizontal16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              AppSpace.size10,
              Text(
                '영화\n제목을 검색해주세요',
                style: AppTextStyle.headline1,
                textAlign: TextAlign.start,
              ),
              AppSpace.size18,
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
                  padding: AppInset.top20 + AppInset.bottom46,
                  focusNode: vm.focusNode,
                  pagingController: vm.pagingController,
                  firstPageErrorText: '영화 제목을 입력해주세요',
                  itemBuilder: (BuildContext context, dynamic item, int index) {
                    final searchedItem = item as SearchedContent;
                    return Obx(
                          () => SearchedContentItemBtn(
                        onBtnTap: () {
                          vm.onSearchedContentTapped(item.contentId);
                        },
                        title: searchedItem.title,
                        posterImgUrl: searchedItem.posterImgUrl,
                        releaseDate: searchedItem.releaseDate,
                        contentType: vm.selectedContentType,
                        isSelected:
                        vm.selectedContentId.value == item.contentId,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Obx(() => AnimatedOpacity(
            opacity: vm.showBtnFloatingBtn.value ? 1 : 0,
            duration: const Duration(milliseconds: 500),
            child: Visibility(
              visible: vm.showBtnFloatingBtn.value ? true : false,
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
                      padding: AppInset.bottom32,
                      child: LinearBgBottomFloatingBtn(
                          text: '다음', onTap: () {})),
                ],
              ),
            ),
          )),
        ),
      ],
    );
  }

  /// 하단 고정 버튼
  /// 다음 페이지로 이동
  @override
  Widget? get buildFloatingActionButton => Obx(
        () => AnimatedOpacity(
      opacity: vm.showBtnFloatingBtn.value ? 1 : 0,
      duration: const Duration(milliseconds: 300),
      child: LinearBgBottomFloatingBtn(text: '다음', onTap: () {}),
    ),
  );

  @override
  FloatingActionButtonLocation? get floatingActionButtonLocation =>
      FloatingActionButtonLocation.centerDocked;
}
