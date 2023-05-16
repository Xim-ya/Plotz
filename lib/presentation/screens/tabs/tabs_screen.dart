import 'package:soon_sak/presentation/screens/home/home_screen.dart';
import 'package:soon_sak/utilities/index.dart';

class TabsScreen extends BaseScreen<TabsViewModel> {
  const TabsScreen({Key? key}) : super(key: key);

  @override
  bool get preventSwipeBack => false;

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget? buildBottomNavigationBar(BuildContext context) =>
      const _BottomNavigationBar();

  @override
  Widget buildScreen(BuildContext context) {
    return Obx(
      () => AnimatedIndexedStack(
        index: vm.selectedTabIndex.value,
        children: const <Widget>[
          HomeScreen(),
          ExploreScreen(),
          CurationScreen(),
          MyPageScreen(),
        ],
      ),
    );
  }
}

class _BottomNavigationBar extends BaseView<TabsViewModel> {
  const _BottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColor.newBlack, // Bg 컬러
        ),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: AppColor.gray06,
                width: vm.selectedTabIndex.value == 1 ? 0.0 : 0.75,
              ),
            ),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              for (final tab in BottomNavigationConstants.values)
                BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(bottom: 5.76),
                    child: SvgPicture.asset(
                      'assets/icons/${tab.iconPath}',
                      color: vm.isTabSelected(tab.indexedKey)
                          ? AppColor.main
                          : AppColor.gray04,
                    ),
                  ),
                  label: tab.label,
                )
            ],
            currentIndex: vm.selectedTabIndex.value,
            selectedItemColor: AppColor.main,
            selectedLabelStyle: AppTextStyle.nav,
            unselectedLabelStyle: AppTextStyle.nav,
            unselectedItemColor: AppColor.gray04,
            onTap: vm.onBottomNavBarItemTapped,
          ),
        ),
      ),
    );
  }
}
