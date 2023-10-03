import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/presentation/screens/requested_content/local_widgets/requested_content_bard_scaffold_screen.dart';
import 'package:soon_sak/presentation/screens/requested_content/local_widgets/requested_content_status_list_view.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class RequestedContentBoardScreen
    extends BaseView<RequestedContentBoardViewModel> {
  const RequestedContentBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RequestedContentBoardScaffold(
      appBar: const _AppBar(),
      tabBar: _buildTabBar(),
      tabView: _buildTabBarView(),
    );
  }

  List<Widget> _buildTabBar() => [
        const Tab(
          text: '신청',
        ),
        const Tab(
          text: '완료',
        ),
        const Tab(
          text: '보류',
        ),
      ];

  List<Widget> _buildTabBarView() =>
      List.generate(3, (index) => RequestedContentStatusListView(index));
}

class _AppBar extends BaseView implements PreferredSizeWidget {
  const _AppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColor.black,
      elevation: 0,
      toolbarHeight: 48,
      title: Text(
        '콘텐츠 요청 내역',
        style: AppTextStyle.title1,
      ),
      leading: SizedBox(
        height: 42,
        child: IconButton(
          onPressed: context.pop,
          icon: SvgPicture.asset(
            'assets/icons/left_arrow.svg',
            height: 24,
            width: 24,
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(48);
}
