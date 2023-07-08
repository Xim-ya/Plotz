import 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchScaffold extends StatefulWidget {
  const SearchScaffold({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabViews;

  @override
  _SearchScaffoldState createState() => _SearchScaffoldState();
}

class _SearchScaffoldState extends State<SearchScaffold>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late SearchScaffoldController _controller;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: widget.tabs.length, vsync: this);
    _controller = locator<SearchScaffoldController>();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            onTap: (index) {
              _controller.onTabClicked(index);
            },
            controller: _tabController,
            tabs: widget.tabs,
          ),
        ),
        Expanded(
          child: Padding(
            padding: AppInset.horizontal16,
            child: TabBarView(
              controller: _tabController,
              children: widget.tabViews,
            ),
          ),
        )
      ],
    );
  }
}
