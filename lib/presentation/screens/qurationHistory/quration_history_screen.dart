import 'package:uppercut_fantube/presentation/screens/qurationHistory/quration_history_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/qurationHistory/tabview/completed_contents_tab_view.dart';
import 'package:uppercut_fantube/presentation/screens/qurationHistory/tabview/in_progress_contents_tab_view.dart';
import 'package:uppercut_fantube/presentation/screens/qurationHistory/tabview/pending_contents_tab_view.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class QurationHistoryScreen extends BaseScreen<QurationHistoryViewModel> {
  const QurationHistoryScreen({super.key});

  @override
  bool get wrapWithSafeArea => false;

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      backgroundColor: AppColor.black,
    );
  }

  @override
  Widget buildScreen(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (__, _) {
        return [
          SliverList(
            delegate: SliverChildListDelegate([
              TabBar(
                labelColor: Colors.white,
                unselectedLabelColor: const Color(0xFF505153),
                indicatorColor: Colors.white,
                labelStyle: AppTextStyle.title3,
                unselectedLabelStyle: AppTextStyle.body2,
                controller: vm.tabController,
                tabs: const [
                  Tab(text: '진행중', height: 42),
                  Tab(text: '등록완료', height: 42),
                  Tab(text: '보류', height: 42),
                ],
              ),
            ]),
          ),
        ];
      },
      body: TabBarView(
        controller: vm.tabController,
        children: [
          InProgressContentTabView(),
          CompletedContentsTabView(),
          PendingContentsTabView()
        ],
      ),
    );
  }
}
