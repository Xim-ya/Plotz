import 'package:soon_sak/utilities/index.dart';

class CurationHistoryScaffold extends StatelessWidget {
  const CurationHistoryScaffold(
      {Key? key,
      required this.tabController,
      required this.tabs,
      required this.tabViews,})
      : super(key: key);

  final TabController tabController;
  final List<Tab> tabs;
  final List<Widget> tabViews;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
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
                    controller: tabController,
                    tabs: [...tabs],
                  ),
                ],
              ),
            ]),
          ),
        ];
      },
      body: TabBarView(controller: tabController, children: [...tabViews]),
    );
  }
}
