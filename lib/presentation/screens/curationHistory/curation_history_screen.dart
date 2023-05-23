import 'package:go_router/go_router.dart';
import 'package:soon_sak/presentation/base/new_base_view.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationHistoryScreen extends NewBaseView<CurationHistoryViewModel> {
  const CurationHistoryScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return CurationHistoryScaffold(
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

}
