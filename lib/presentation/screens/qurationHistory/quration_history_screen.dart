import 'package:soon_sak/utilities/index.dart';

class QurationHistoryScreen extends BaseScreen<QurationHistoryViewModel> {
  const QurationHistoryScreen({super.key});

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return QurationHistoryScaffold(
      tabController: vm.tabController,
      tabs: _buildTabs(),
      tabViews: _buildTabViews(),
    );
  }

  List<Tab> _buildTabs() => const [
        Tab(text: '진행중', height: 42),
        Tab(text: '등록완료', height: 42),
        Tab(text: '보류', height: 42),
      ];

  List<Widget> _buildTabViews() => [
        const InProgressContentTabView(),
        const CompletedContentsTabView(),
        const PendingContentsTabView()
      ];

  @override
  PreferredSizeWidget? buildAppBar(BuildContext context) {
    return AppBar(
      toolbarHeight: 56,
      elevation: 0,
      leading: GestureDetector(
        onTap: vm.routeBack,
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
    );
  }
}
