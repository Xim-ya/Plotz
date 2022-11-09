import 'package:uppercut_fantube/presentation/common/sticky_delegate_container.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold_controller.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* 2022.07.14 Created By Ximya
* 광고수익금 스크린의 Scaffold
* [SliverPersistentHeader]을 이용해 `Tabar`가 고정되는 인터렉션을 고려함.
* */

class ContentDetailScaffold extends BaseView<ContentDetailScaffoldController> {
  const ContentDetailScaffold({
    Key? key,
    required this.tabBarViews,
    required this.tabs,
    required this.header,
    required this.rateAndGenreView,
  }) : super(key: key);

  final Widget header;
  final List<Tab> tabs;
  final List<Widget> tabBarViews;
  final Widget rateAndGenreView;

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
              imageUrl:
                  'https://image.tmdb.org/t/p/w1280/euYz4adiSHH0GE3YnTeh3uLfBvL.jpg',
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ),
        // Graident 레이어
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
        rateAndGenreView,
        CustomScrollView(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          controller: vm.scrollController,
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate([header]),
            ),
            // 탭바 영역
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
            ),

            // TabBarView 영역
            SliverList(
              delegate: SliverChildListDelegate([
                Obx(
                  () => tabBarViews[vm.selectedTabIndex.value],
                )
              ]),
            ),
          ],
        ),

        // 상단 '뒤로가기' 버튼
        // 특정 [ScrollOffset]에 화면 밖으로 이동하는 인터렉션이 있음
        Obx(
          () => AnimatedPositioned(
            top: vm.showBackBtnOnTop.value ? 0 : -100,
            left: 12,
            duration: const Duration(milliseconds: 100),
            child: IconButton(
              onPressed: Get.back,
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
            bottom:
                vm.showBackBtnOnTop.value ? -100 : SizeConfig.to.bottomInset,
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
