import 'package:soon_sak/utilities/index.dart';

/* 2022.07.14 Created By Ximya
* 광고수익금 스크린의 Scaffold
* [SliverPersistentHeader]을 이용해 `Tabar`가 고정되는 인터렉션을 고려함.
* */

class ContentDetailScaffold extends BaseView<ContentDetailScaffoldController> {
  const ContentDetailScaffold({
    Key? key,
    required this.tabViews,
    required this.tabs,
    required this.header,
    required this.rateAndGenreView,
    required this.headerBackdropImgUrl,
  }) : super(key: key);

  final Widget header;
  final List<Tab> tabs;
  final List<Widget> tabViews;
  final Widget rateAndGenreView;
  final String headerBackdropImgUrl;

  @override
  Widget buildView(BuildContext context) {
    return Stack(
      children: <Widget>[
        Obx(
          () => AnimatedPositioned(
            top: vm.headerBgOffset,
            duration: const Duration(milliseconds: 40),
            child: CachedNetworkImage(
              width: SizeConfig.to.screenWidth,
              fit: BoxFit.fitWidth,
              imageUrl: headerBackdropImgUrl.prefixTmdbImgPath,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),

        // Gradient 레이어
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent, AppColor.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.3, 0.8],
              ),
            ),
          ),
        ),

        // Rate & Genre 뷰
        Obx(
          () => AnimatedPositioned(
              top: 180 - vm.headerBgOffset,
              right: 16,
              duration: const Duration(milliseconds: 200),
              child: rateAndGenreView),
        ),
        DefaultTabController(
          length: 2,
          child: NestedScrollView(
            controller: vm.scrollController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return [
                SliverList(
                  delegate: SliverChildListDelegate([
                    header,
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
                        onTap: vm.onTabClicked,
                        controller: vm.tabController,
                        tabs: tabs,
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
                controller: vm.tabController,
                children: [
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    child: tabViews[0],
                  ),
                  SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 80),
                    child: tabViews[1],
                  ),
                ],
              ),
            ),
          ),
        ),

        // 상단 '뒤로가기'   버튼
        // 특정 [ScrollOffset]에 화면 밖으로 이동하는 인터렉션이 있음
        Obx(
          () => AnimatedPositioned(
            top: vm.showBackBtnOnTop.value ? 0 : -100,
            left: 12,
            duration: const Duration(milliseconds: 100),
            child: IconButton(
              onPressed: ContentDetailViewModel.to.onRouteBack,
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
        ),

        // 하단 '뒤로가기' 버튼
        // 특정 [ScrollOffset]에 화면 밖으로 이동하는 인터렉션이 있음
        Obx(
          () => AnimatedPositioned(
            bottom: vm.showBackBtnOnTop.value
                ? -100
                : SizeConfig.to.responsiveBottomInset,
            right: 14,
            duration: const Duration(milliseconds: 160),
            child: FloatingActionButton(
              onPressed: Get.back,
              backgroundColor: AppColor.darkGrey.withOpacity(0.46),
              child: const Icon(Icons.arrow_back),
            ),
          ),
        ),
      ],
    );
  }
}
