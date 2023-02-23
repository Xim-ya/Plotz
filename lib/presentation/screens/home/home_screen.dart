import 'dart:ui';
import 'package:soon_sak/utilities/index.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return HomeScaffold(
      scrollController: vm.scrollController,
      animationAppbar: _buildAnimationAppbar(),
      stackedGradientPosterBg: _buildStackedGradientPosterBg(),
      topBannerSlider: _buildTopBannerSlider(),
      topTenContentSlider: _buildTopTenContentSlider(),
      categoryContentCollectionList: _buildCategoryContentCollectionList(),
      body: _buildBody(),
      appBarHeight: vm.appBarHeight,
    );
  }

  /// 카테고리 리스트 - 각 리스트 안에 포스트 슬라이더 위젯이 구성되어 있음.
  List<Widget> _buildCategoryContentCollectionList() => [
        Obx(
          () => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: vm.categoryContentCollection?.items.length ?? 4,
            separatorBuilder: (__, _) => AppSpace.size16,
            itemBuilder: (context, index) {
              if (vm.categoryContentCollection.hasData) {
                final item = vm.categoryContentCollection!.items[index];
                return CategoryContentSectionView(
                  contentSectionData: item,
                  onContentTapped: (nestedIndex) {
                    final argument = ContentArgumentFormat(
                      contentId: item.contents[nestedIndex].id,
                      contentType: item.contents[nestedIndex].contentType,
                      posterImgUrl: item.contents[nestedIndex].posterImgUrl,
                      originId: item.contents[nestedIndex].originId,
                    );
                    vm.routeToContentDetail(argument);
                  },
                );
              } else {
                return const CategoryContentSectionSkeletonView();
              }
            },
          ),
        ),
        AppSpace.size72,
      ];

  // 임시 body
  List<Widget> _buildBody() => [
        AppSpace.size72,
      ];

  // 상단 'Top10' 포스트 슬라이더
  List<Widget> _buildTopTenContentSlider() => [
        AppSpace.size40,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '순삭 Top10',
            style: AppTextStyle.headline2,
          ),
        ),
        AppSpace.size6,
        Obx(
          () => ContentPostSlider(
            height: 200,
            itemCount: vm.topTenContents?.contentList?.length ?? 5,
            itemBuilder: (context, index) {
              if (vm.isTopTenContentsLoaded) {
                final item = vm.topTenContents!.contentList![index];
                return GestureDetector(
                  onTap: () {
                    final argument = ContentArgumentFormat(
                      contentId: item.contentId,
                      contentType: item.contentType,
                      posterImgUrl: item.posterImgUrl,
                      originId: item.originId,
                    );
                    vm.routeToContentDetail(argument);
                  },
                  child: ContentPostItem(
                    imgUrl: vm.topTenContents!.contentList![index].posterImgUrl
                        .prefixTmdbImgPath,
                  ),
                );
              } else {
                return const ContentPostItem(imgUrl: null);
              }
            },
          ),
        ),
      ];

  // 상단 배너 슬라이더
  Widget _buildTopBannerSlider() => Obx(
        () => CarouselSlider.builder(
          carouselController: vm.carouselController,
          itemCount: vm.bannerContentList?.length ?? 2,
          options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, _) {
              vm.onBannerSliderSwiped(index);
            },
            viewportFraction: 0.93,
            aspectRatio: 337 / 276,
          ),
          itemBuilder:
              (BuildContext context, int itemIndex, int pageViewIndex) {
            if (vm.isBannerContentsLoaded) {
              final BannerItem item = vm.bannerContentList![itemIndex];
              return BannerItemView(
                title: item.title,
                description: item.description,
                imgUrl: item.imgUrl,
                onItemTapped: () {
                  final argument = ContentArgumentFormat(
                    contentId: item.id,
                    contentType: item.type,
                    posterImgUrl: item.backdropImgUrl,
                    thumbnailUrl: item.imgUrl,
                    videoId: item.videoId,
                    videoTitle: item.title,
                    originId: item.originId,
                  );
                  vm.routeToContentDetail(argument);
                },
              );
            } else {
              return const BannerSkeletonItem();
            }
          },
        ),
      );

  // 배경 위젯 - Poster + Gradient Image 로 구성됨.
  List<Widget> _buildStackedGradientPosterBg() => [
        Obx(() {
          if (vm.isBannerContentsLoaded) {
            return CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl: vm
                  .selectedTopExposedContent!.backdropImgUrl.prefixTmdbImgPath,
              errorWidget: (context, url, error) => const Icon(Icons.error),
            );
          } else {
            return const SizedBox();
          }
        }),
        // Graident 레이어
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Colors.transparent, AppColor.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.5, 1.0],
              ),
            ),
          ),
        )
      ];

  // 애니메이션 앱바 - 스크롤 동작 및 offset에 따라 blur animation이 적용됨.
  List<Widget> _buildAnimationAppbar() {
    return [
      Obx(
        () => AnimatedOpacity(
          opacity: vm.showBlurAtAppBar.value ? 1 : 0,
          duration: const Duration(milliseconds: 300),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                height: vm.appBarHeight,
                color: Colors.transparent,
              ),
            ),
          ),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight) +
            const EdgeInsets.symmetric(horizontal: 16),
        color: Colors.transparent,
        height: vm.appBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                AlertWidget.toast('이렇게 토스트 메세지가 나옵니다');
                // vm.update();
                // LocalStorageService.to.deleteData(fieldName: 'topTen');
                // vm.firebaseStoreTest();
              },
              child: Image.asset(
                'assets/images/main_logo.png',
                height: 40,
                width: 40,
              ),
            ),
            IconInkWellButton.assetIcon(
              iconPath: 'assets/icons/search.svg',
              size: 40,
              onIconTapped: vm.routeToSearch,
            )
          ],
        ),
      )
    ];
  }
}
