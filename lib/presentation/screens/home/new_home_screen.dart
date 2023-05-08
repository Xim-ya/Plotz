import 'package:dots_indicator/dots_indicator.dart';
import 'package:soon_sak/presentation/common/image/new_content_post_item.dart';
import 'package:soon_sak/presentation/screens/home/localWidget/new_home_scaffold.dart';
import 'package:soon_sak/presentation/screens/home/localWidget/paged_category_list_view.dart';
import 'package:soon_sak/utilities/index.dart';

class NewHomeScreen extends BaseScreen<HomeViewModel> {
  const NewHomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return NewHomeScaffold(
      stackedTopGradient: _buildStackedTopGradient(),
      stackedAppBar: _buildStackedAppBar(),
      topBannerSlider: const _BannerSlider(),
      topTenContentSlider: const _TopTenContentSlider(),
      scrollController: vm.scrollController,
      stackedGradientPosterBg: _buildStackedGradientPosterBg(),
      categoryContentCollectionList: _buildCategoryCollection(),
      topPositionedContentSliderList: _buildTopPositionedContentSliderList(),
    );
  }

  List<Widget> _buildTopPositionedContentSliderList() {
    return List.generate(3, (index) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '여름엔 청춘',
              style: AppTextStyle.title2,
            ),
          ),
          AppSpace.size7,
          Obx(
            () => ContentPostSlider(
              height: 158,
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
                      vm.routeToContentDetail(argument, sectionType: 'topTen');
                    },
                    child: NewContentPostItem(
                      imgUrl: vm.topTenContents!.contentList![index]
                          .posterImgUrl.prefixTmdbImgPath,
                    ),
                  );
                } else {
                  return const NewContentPostItem(imgUrl: null);
                }
              },
            ),
          ),
        ],
      );
    });
  }

  Widget _buildStackedAppBar() => Padding(
        padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight) +
            AppInset.horizontal16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SvgPicture.asset('assets/icons/new_logo.svg'),
            // TODO ICON INWELL BUTTON MODULE 수정 필요
            MaterialButton(
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              minWidth: 0,
              padding: EdgeInsets.zero,
              onPressed: vm.routeToSearch,
              child: SvgPicture.asset(
                'assets/icons/new_search.svg',
              ),
            ),
          ],
        ),
      );

  Widget _buildStackedTopGradient() => IgnorePointer(
        child: Container(
          height: 148,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF000000),
                Color.fromRGBO(15, 15, 15, 0.8177),
                Color.fromRGBO(15, 15, 15, 0.62),
                Colors.transparent,
              ],
              stops: [0.0, 0.3539, 0.5168, 1.0],
              // stops: [0.0, 0.1823, 0.375, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      );

  /// 카테고리 리스트 - 각 리스트 안에 포스트 슬라이더 위젯이 구성되어 있음.
  Widget _buildCategoryCollection() => PagedCategoryListView(
        pagingController: vm.pagingController,
        itemBuilder: (BuildContext context, dynamic item, int index) {
          return CategoryContentSectionView(
            contentSectionData: item,
            onContentTapped: (nestedIndex) {
              final argument = ContentArgumentFormat(
                contentId: item.contents[nestedIndex].id,
                contentType: item.contents[nestedIndex].contentType,
                posterImgUrl: item.contents[nestedIndex].posterImgUrl,
                originId: item.contents[nestedIndex].originId,
              );
              vm.routeToContentDetail(argument, sectionType: 'category');
            },
          );
        },
      );

  /// 배경 위젯 - Poster + Gradient Image 로 구성됨.
  List<Widget> _buildStackedGradientPosterBg() => [
        Obx(() {
          if (vm.isBannerContentsLoaded) {
            return CachedNetworkImage(
              width: double.infinity,
              fit: BoxFit.fitWidth,
              imageUrl:
                  vm.selectedBannerContentBackdropImgUrl!.prefixTmdbImgPath,
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
                colors: [
                  Colors.black,
                  Colors.transparent,
                  AppColor.black,
                  AppColor.black
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.5, 0.7, 1.0],
              ),
            ),
          ),
        )
      ];
}

/// 상단 배너 슬라이더
class _BannerSlider extends BaseView<HomeViewModel> {
  const _BannerSlider({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Obx(
      () => Stack(
        children: [
          GestureDetector(
            onTap: (){
              print(vm.topPositionedCategory.value?.length ?? " NONE ");
            },
            child: CarouselSlider.builder(
              carouselController: vm.carouselController,
              itemCount: vm.bannerContentList?.length ?? 2,
              options: CarouselOptions(
                height: 500,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1800),
                onPageChanged: (index, _) {
                  vm.onBannerSliderSwiped(index);
                },
                onScrolled: vm.onBannerSliderScrolled,
                viewportFraction: 1,
                // aspectRatio: 375 / 500,
                // aspectRatio: 337 / 276,
              ),
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) {
                if (vm.isBannerContentsLoaded) {
                  final BannerItem item = vm.bannerContentList![itemIndex];
                  return CachedNetworkImage(
                    imageUrl: item.imgUrl,
                    fit: BoxFit.fitHeight,
                  );
                } else {
                  return const BannerSkeletonItem();
                }
              },
            ),
          ),

          // 하단 그레디언트,  Bottom Gradient Container
          Positioned(
            bottom: -8,
            child: IgnorePointer(
              child: Container(
                width: SizeConfig.to.screenWidth,
                height: 156,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromRGBO(15, 15, 15, 0),
                      Color.fromRGBO(15, 15, 15, 0.6),
                      Color.fromRGBO(15, 15, 15, 0.8),
                      Color.fromRGBO(15, 15, 15, 1),
                    ],
                    stops: [0.0, 0.3539, 0.5168, 1.0],
                    // stops: [0.0, 0.1823, 0.375, 1.0],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),

          // 콘텐츠 정보 섹션
          Positioned(
            bottom: 8,
            child: SizedBox(
              width: SizeConfig.to.screenWidth,
              child: Column(
                children: <Widget>[
                  Text(
                    '나에게 딱 맞는 콘텐츠',
                    style: AppTextStyle.title3
                        .copyWith(color: AppColor.main, letterSpacing: -0.2),
                  ),
                  AppSpace.size2,
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: vm.bannerInfoOpacity.value,
                    child: Column(
                      children: [
                        Text(
                          vm.selectedBannerContent?.title ?? '',
                          style:
                              AppTextStyle.web3.copyWith(letterSpacing: -0.2),
                        ),
                        AppSpace.size4,
                        Text(
                          '코미디 · 드라마 · 스릴러',
                          style: AppTextStyle.alert2.copyWith(
                              color: AppColor.gray03, letterSpacing: -0.2),
                        ),
                      ],
                    ),
                  ),
                  AppSpace.size12,
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: DotsIndicator(
                      dotsCount: vm.bannerContentList?.length ?? 4,
                      position: vm.bannerContentsSliderIndex.value.toDouble(),
                      decorator: const DotsDecorator(
                        spacing: EdgeInsets.symmetric(horizontal: 4),
                        size: Size(4, 4),
                        activeSize: Size(4, 4),
                        color: AppColor.gray05,
                        // Inactive color
                        activeColor: AppColor.gray02,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopTenContentSlider extends BaseView<HomeViewModel> {
  const _TopTenContentSlider({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpace.size40,
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            '지금 뜨고있는 인기 콘텐츠',
            style: AppTextStyle.title2,
          ),
        ),
        AppSpace.size7,
        Obx(
          () => ContentPostSlider(
            height: 158,
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
                    vm.routeToContentDetail(argument, sectionType: 'topTen');
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
      ],
    );
  }
}
