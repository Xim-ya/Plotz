import 'package:uppercut_fantube/presentation/screens/search/localWidget/search_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/search/localWidget/tabViews/drama_searched_results_tab_view.dart';
import 'package:uppercut_fantube/presentation/screens/search/search_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

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
        const DramaSearchedResultsTabView(),
        Container(),
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
            SizedBox(
              height: 40,
              width: SizeConfig.to.screenWidth - 84,
              child: Stack(
                children: [
                  TextFormField(
                    keyboardAppearance: Brightness.dark,
                    focusNode: FocusNode(),
                    onChanged: (String) {},
                    controller: vm.textEditingController,
                    cursorColor: AppColor.lightGrey,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: 'pretendard_regular'),
                    decoration: InputDecoration(
                      filled: true,
                      contentPadding:
                          const EdgeInsets.only(left: 38, right: 40),
                      hintText: '제목을 입력하세요',
                      errorBorder: InputBorder.none,
                      enabledBorder: fixedOutLinedBorder(),
                      disabledBorder: fixedOutLinedBorder(),
                      focusedBorder: fixedOutLinedBorder(),
                      fillColor: AppColor.strongGrey,
                      hintStyle: TextStyle(
                          fontSize: 16,
                          color: AppColor.lightGrey.withOpacity(0.4),
                          fontFamily: 'pretendard_regular'),
                    ),
                  ),
                  // 검색창 prefix 검색 아이콘
                  Positioned(
                    child: Container(
                      alignment: Alignment.center,
                      width: 40,
                      child: const Icon(
                        Icons.search_rounded,
                        color: AppColor.lightGrey,
                      ),
                    ),
                  ),
                  // 'X' 버튼
                  Positioned(
                    right: 0,
                    child: GestureDetector(
                      onTap: vm.resetSearchValue,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        height: 40,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: const BoxDecoration(
                            color: AppColor.lightGrey,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close_rounded,
                            size: 12,
                            color: AppColor.strongGrey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // 취소 버튼
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

  // [TextField] OutLinedBorder 속성
  OutlineInputBorder fixedOutLinedBorder() {
    return const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6)),
        borderSide: BorderSide(color: Colors.transparent));
  }
}
