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
          QurationScreen(),
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
          canvasColor: AppColor.strongGrey, // Bg 컬러
        ),
        child: BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            for (final tab in BottomNavigationConstants.values)
              BottomNavigationBarItem(
                icon: tab.icon,
                label: tab.label,
              )
          ],
          currentIndex: vm.selectedTabIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          onTap: vm.onBottomNavBarItemTapped,
        ),
      ),
    );
  }
}
