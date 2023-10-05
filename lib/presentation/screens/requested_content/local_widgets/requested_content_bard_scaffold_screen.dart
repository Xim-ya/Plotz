import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_view_model.dart';

class RequestedContentBoardScaffold extends StatefulWidget {
  const RequestedContentBoardScaffold(
      {Key? key,
      required this.tabBar,
      required this.tabView,
      required this.appBar})
      : super(key: key);

  final List<Widget> tabBar;
  final List<Widget> tabView;
  final PreferredSizeWidget appBar;

  @override
  State<RequestedContentBoardScaffold> createState() =>
      _RequestedContentBoardScaffoldState();
}

class _RequestedContentBoardScaffoldState
    extends State<RequestedContentBoardScaffold>
    with SingleTickerProviderStateMixin {
  late final TabController tabController =
      TabController(length: 3, vsync: this);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RequestedContentBoardViewModel>(
      create: (_) {
        final vm = locator<RequestedContentBoardViewModel>();
        vm.initContext(context);
        vm.onIntentInit(tabController);
        return vm;
      },
      child: Scaffold(
        appBar: widget.appBar,
        backgroundColor: AppColor.black,
        body: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 0.75,
                        color: AppColor.gray05,
                      ),
                    ),
                    color: AppColor.black,
                  ),
                  child: TabBar(
                    controller: tabController,
                    tabs: widget.tabBar,
                    indicator: UnderlineTabIndicator(
                      borderSide:
                          const BorderSide(width: 2, color: AppColor.main),
                      insets: EdgeInsets.symmetric(
                        horizontal: SizeConfig.to.screenWidth / 4.2,
                      ),
                    ),
                    labelColor: AppColor.white,
                    unselectedLabelColor: AppColor.gray03,
                    indicatorColor: AppColor.main,
                    labelStyle: AppTextStyle.body3,
                    unselectedLabelStyle: AppTextStyle.body3,
                  ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: widget.tabView,
              ),
            )
          ],
        ),
      ),
    );
  }
}
