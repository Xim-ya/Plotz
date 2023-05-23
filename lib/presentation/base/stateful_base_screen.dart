import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/utilities/index.dart';

/* 2022.07.14 Created By Ximya
* 광고수익금 스크린의 Scaffold
* [SliverPersistentHeader]을 이용해 `Tabar`가 고정되는 인터렉션을 고려함.
* */

class NewContentDetailScaffold extends StatefulWidget {
  const NewContentDetailScaffold({
    required this.tabViews,
    required this.tabs,
    required this.header,
    required this.rateAndGenreView,
    required this.headerBgImg,
    Key? key,
  }) : super(key: key);

  final Widget header;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final Widget rateAndGenreView;
  final Widget headerBgImg;

  @override
  _NewContentDetailScaffoldState createState() =>
      _NewContentDetailScaffoldState();
}

class _NewContentDetailScaffoldState extends State<NewContentDetailScaffold>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ContentDetailViewModel>(
      create: (context) {
        final vm = locator<ContentDetailViewModel>();
        vm.onIntentInit(tabController);
        vm.initContext(context);
        return vm;
      },
      builder: (context, _) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.zero,
            child: AppBar(
              backgroundColor: Colors.black,
            ),
          ),
          backgroundColor: AppColor.black,
          body: Stack(
            children: <Widget>[
              Selector<ContentDetailViewModel, double>(
                selector: (context, vm) => vm.headerBgOffset,
                builder: (context, headerBgOffset, __) {
                  return AnimatedPositioned(
                    top: headerBgOffset,
                    duration: const Duration(milliseconds: 40),
                    child: widget.headerBgImg,
                  );
                },
              ),

              // Gradient 레이어
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black,
                        Colors.transparent,
                        AppColor.black
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: <double>[0.0, 0.3, 0.8],
                    ),
                  ),
                ),
              ),

              Selector<ContentDetailViewModel, double>(
                selector: (context, vm) => vm.headerBgOffset,
                builder: (context, headerBgOffset, __) {
                  return AnimatedPositioned(
                    top: 180 - headerBgOffset,
                    right: 16,
                    duration: const Duration(milliseconds: 200),
                    child: widget.rateAndGenreView,
                  );
                },
              ),

              DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  controller:
                      context.read<ContentDetailViewModel>().scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      SliverList(
                        delegate: SliverChildListDelegate([
                          widget.header,
                        ]),
                      ),
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyDelegateContainer(
                          minHeight: 44,
                          maxHeight: 1,
                          child: Container(
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
                              onTap: (int index) {
                                context
                                    .read<ContentDetailViewModel>()
                                    .onTabClicked(index);
                              },
                              controller: tabController,
                              tabs: widget.tabs,
                            ),
                          ),
                        ),
                      )
                    ];
                  },
                  body: Container(
                    color: AppColor.black,
                    padding: const EdgeInsets.only(top: 20),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 80),
                          child: widget.tabViews[0],
                        ),
                        SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          padding: const EdgeInsets.only(bottom: 80),
                          child: widget.tabViews[1],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              // 상단 '뒤로가기'   버튼
              // 특정 [ScrollOffset]에 화면 밖으로 이동하는 인터렉션이 있음
              Selector<ContentDetailViewModel, bool>(
                selector: (context, vm) => vm.showBackBtnOnTop,
                builder: (context, showBackBtnOnTop, __) {
                  return AnimatedPositioned(
                    top: showBackBtnOnTop ? 0 : -100,
                    left: 12,
                    duration: const Duration(milliseconds: 100),
                    child: IconButton(
                      onPressed: () {
                        context
                            .read<ContentDetailViewModel>()
                            .onRouteBack(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),

              // 하단 '뒤로가기' 버튼
              // 특정 [ScrollOffset]에 화면 밖으로 이동하는 인터렉션이 있음
              Selector<ContentDetailViewModel, bool>(
                selector: (context, vm) => vm.showBackBtnOnTop,
                builder: (context, showBackBtnOnTop, __) {
                  return AnimatedPositioned(
                    bottom: showBackBtnOnTop
                        ? -100
                        : SizeConfig.to.responsiveBottomInset,
                    right: 14,
                    duration: const Duration(milliseconds: 160),
                    child: FloatingActionButton(
                      onPressed: context.pop,
                      backgroundColor: AppColor.darkGrey.withOpacity(0.46),
                      child: const Icon(Icons.arrow_back),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
