import 'package:uppercut_fantube/presentation/screens/explore/explore_screen.dart';
import 'package:uppercut_fantube/presentation/screens/my/my_page_screen.dart';
import 'package:uppercut_fantube/utilities/index.dart';

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
      () => BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          for (final tab in BottomNavigationConstants.values)
            BottomNavigationBarItem(
              icon: tab.icon,
              label: tab.label,
            )
        ],
        currentIndex: vm.selectedTabIndex.value,
        backgroundColor: AppColor.strongGrey,
        selectedItemColor: Colors.white,
        onTap: vm.onBottomNavBarItemTapped,
      ),
    );
  }
}
