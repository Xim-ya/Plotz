import 'package:uppercut_fantube/presentation/common/sticky_delegate_container.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold_controller.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* 2022.07.14 Created By Ximya
* 광고수익금 스크린의 Scaffold
* [SliverPersistentHeader]을 이용해 `Tabar`가 고정되는 인터렉션을 고려함.
* */

class ContentDetailScaffold extends BaseView<ContentDetailScaffoldController> {
  const ContentDetailScaffold({
    Key? key,
    required this.tabBarViews,
    required this.tabs,
    required this.header,
    required this.appBarLeading,
  }) : super(key: key);

  final IconButton appBarLeading;
  final Widget header;
  final List<Tab> tabs;
  final List<Widget> tabBarViews;

  @override
  Widget buildView(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: CustomScrollView(
        controller: vm.scrollController,
        slivers: [
          // AppBar 영역
          SliverAppBar(
            pinned: true,
            expandedHeight: 56,
            backgroundColor: Colors.blue,
            elevation: 0,
            leading: appBarLeading,

          ),
          // Header 영역
          SliverList(
            delegate: SliverChildListDelegate([header]),
          ),
          // 탭바 영역
          SliverPersistentHeader(
            pinned: true,
            delegate: StickyDelegateContainer(
              minHeight: 44,
              maxHeight: 1,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration:  BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.yellow),
                  ),
                  color: Colors.purple,
                ),
                child: TabBar(
                  labelColor: AppColor.black,
                  unselectedLabelColor: Colors.brown,
                  indicatorColor: AppColor.black,
                  labelStyle: AppTextStyle.title3,
                  unselectedLabelStyle:
                  AppTextStyle.body2.copyWith(color: AppColor.mixedWhite),
                  onTap: vm.onTabClicked,
                  controller: vm.tabController,
                  tabs: tabs,
                ),
              ),
            ),
          ),

          // TabBarView 영역
          SliverList(
            delegate: SliverChildListDelegate([
              Obx(
                    () => tabBarViews[vm.selectedTabIndex.value],
              )
            ]),
          ),
        ],
      ),
    );
  }
}
