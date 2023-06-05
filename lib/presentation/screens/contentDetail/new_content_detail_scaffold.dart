import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/utilities/index.dart';

/* 2022.07.14 Created By Ximya
* 광고수익금 스크린의 Scaffold
* [SliverPersistentHeader]을 이용해 `Tabar`가 고정되는 인터렉션을 고려함.
* */

class NewContentDetailScaffold extends StatefulWidget {
  const NewContentDetailScaffold({
    required this.appBar,
    required this.tabViews,
    required this.tabs,
    required this.header,
    required this.headerDescription,
    required this.rateAndGenreView,
    required this.playBtn,
    Key? key,
  }) : super(key: key);

  final Widget appBar;
  final Widget header;
  final Widget headerDescription;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final Widget rateAndGenreView;
  final Widget playBtn;

  @override
  _NewContentDetailScaffoldState createState() =>
      _NewContentDetailScaffoldState();
}

class _NewContentDetailScaffoldState extends State<NewContentDetailScaffold>
    with SingleTickerProviderStateMixin {
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
          backgroundColor: AppColor.black,
          body: Stack(
            children: <Widget>[
              // Header 포스터 이미지
              StreamBuilder(
                stream: context
                    .read<ContentDetailViewModel>()
                    .headerImgOffsets
                    .stream,
                builder: (context, snapshot) => AnimatedPositioned(
                  top: snapshot.data ?? 0,
                  right: 0,
                  left: 0,
                  duration: const Duration(milliseconds: 40),
                  child: widget.header,
                ),
              ),
              DefaultTabController(
                length: 2,
                child: NestedScrollView(
                  controller:
                      context.read<ContentDetailViewModel>().scrollController,
                  headerSliverBuilder:
                      (BuildContext context, bool innerBoxIsScrolled) {
                    return [
                      /// Persistent 앱바
                      /// SliverAppBar 너무 무겁기 때문에 [SliverPersistentHeader]로 대체
                      SliverPersistentHeader(
                        pinned: true,
                        delegate: StickyDelegateContainer(
                          minHeight: 48 + SizeConfig.to.statusBarHeight,
                          maxHeight: 1,
                          child: widget.appBar,
                        ),
                      ),
                      // Header 영역을 잡아주는 컨테이너. 공간만 차지해주는 역할을 함. + 하단 Gradient
                      SliverToBoxAdapter(
                        child: Stack(
                          children: [
                            SizedBox(
                              height: SizeConfig.to.screenHeight * (375 / 500) -
                                  (48 + SizeConfig.to.statusBarHeight),
                              child: Center(child: widget.playBtn),
                            ),
                            // 헤더 포스터 '하단' Gradient
                            Positioned(
                              bottom: 0,
                              child: Container(
                                width: SizeConfig.to.screenWidth,
                                height: 88,
                                decoration: const BoxDecoration(
                                    gradient: AppGradient.singleBottomToTop),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // 콘텐츠 설명 섹션
                      SliverToBoxAdapter(
                        child: widget.headerDescription,
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
                                bottom: BorderSide(
                                  width: 0.75,
                                  color: AppColor.gray06,
                                ),
                              ),
                              color: AppColor.black,
                            ),
                            child: TabBar(
                              indicator: UnderlineTabIndicator(
                                borderSide: const BorderSide(
                                    width: 2, color: AppColor.main),
                                insets: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.to.screenWidth / 3.33,
                                ),
                              ),
                              labelColor: AppColor.white,
                              unselectedLabelColor: AppColor.gray04,
                              indicatorColor: AppColor.main,
                              labelStyle: AppTextStyle.body3,
                              unselectedLabelStyle: AppTextStyle.body3,
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
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: widget.tabViews[0],
                        ),
                        SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          child: widget.tabViews[1],
                        ),
                      ],
                    ),
                  ),
                ),
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
