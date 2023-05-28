import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationHistoryScaffold extends StatefulWidget {
  const CurationHistoryScaffold({
    Key? key,
    required this.tabs,
    required this.tabViews,
  }) : super(key: key);

  final List<Tab> tabs;
  final List<Widget> tabViews;

  @override
  _CurationHistoryScaffoldState createState() =>
      _CurationHistoryScaffoldState();
}

class _CurationHistoryScaffoldState extends State<CurationHistoryScaffold>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final vm = locator<CurationHistoryViewModel>();
        vm.initContext(context);
        return vm;
      },
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 56,
          elevation: 0,
          leading: GestureDetector(
            onTap: context.pop,
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColor.mixedWhite,
            ),
          ),
          title: Text(
            '큐레이션 내역',
            style: AppTextStyle.title2,
          ),
          backgroundColor: AppColor.black,
        ),
        backgroundColor: AppColor.black,
        body: NestedScrollView(
          headerSliverBuilder: (__, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Stack(
                    children: [
                      Positioned.fill(
                        child: Container(
                          height: 10,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Color(0xFF1B1C1E)),
                            ),
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                      TabBar(
                        labelColor: Colors.white,
                        unselectedLabelColor: const Color(0xFF505153),
                        indicatorColor: Colors.white,
                        labelStyle: AppTextStyle.title3,
                        unselectedLabelStyle: AppTextStyle.body2,
                        controller: _tabController,
                        tabs: [...widget.tabs],
                      ),
                    ],
                  ),
                ]),
              ),
            ];
          },
          body: TabBarView(
              controller: _tabController, children: [...widget.tabViews]),
        ),
      ),
    );
  }
}
