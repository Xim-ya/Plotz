import 'package:uppercut_fantube/utilities/index.dart';

class SearchScaffold extends BaseView<SearchScaffoldController> {
  const SearchScaffold({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabViews;

  @override
  Widget buildView(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: AppInset.top6,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Color(0xFF1B1C1E)),
            ),
            color: AppColor.black,
          ),
          child: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: const Color(0xFF505153),
            indicatorColor: Colors.white,
            labelStyle: AppTextStyle.title3,
            unselectedLabelStyle: AppTextStyle.body2,
            controller: vm.tabController,
            tabs: tabs,
          ),
        ),
        Expanded(
          child: Padding(
            padding: AppInset.horizontal16,
            child: TabBarView(
              controller: vm.tabController,
              children: tabViews,
            ),
          ),
        )
      ],
    );
  }
}
