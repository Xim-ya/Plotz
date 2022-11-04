import 'package:uppercut_fantube/presentation/screens/tabs/tabs_view_model.dart';
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
  Widget buildBody(BuildContext context) {
    return Obx(() => IndexedStack(
          index: vm.selectedTabIndex.value,
          children: <Widget>[
            Container(),
            Container(
              child: Center(
                child: Text('Screen 1', style: TextStyle(
                  color: Colors.white
                ),),
              ),
            ),
            Container(
              child: Center(
                child: Text('Screen 2', style: TextStyle(
                    color: Colors.white
                ),),
              ),
            ),
          ],
        ),);
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
        backgroundColor: AppColor.darkGrey,
        selectedItemColor: Colors.amber[800],
        onTap: vm.onBottomNavBarItemTapped,
      ),
    );
  }
}
