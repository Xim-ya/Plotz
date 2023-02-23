import 'package:soon_sak/presentation/screens/newSearch/localWidget/new_search_scaffold_controller.dart';
import 'package:soon_sak/utilities/index.dart';

class NewSearchScaffold extends BaseView<NewSearchScaffoldController> {
  const NewSearchScaffold({
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
            onTap: vm.onTabClicked,
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
