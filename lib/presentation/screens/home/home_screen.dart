import 'package:dots_indicator/dots_indicator.dart';
import 'package:soon_sak/presentation/common/image/new_content_post_item.dart';
import 'package:soon_sak/presentation/screens/home/localWidget/home_scaffold.dart';
import 'package:soon_sak/presentation/screens/home/localWidget/paged_category_list_view.dart';
import 'package:soon_sak/utilities/index.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Color? get screenBackgroundColor => AppColor.newBlack;

  @override
  Widget buildScreen(BuildContext context) {
    return HomeScaffold(
      stackedTopGradient: _buildStackedTopGradient(),
      stackedAppBar: _buildStackedAppBar(),
      topBannerSlider: const _BannerSlider(),
      topTenSlider: const _TopTenContentSlider(),
      channelSlider: const _ChannelSlider(),
      scrollController: vm.scrollController,
      stackedGradientPosterBg: _buildStackedGradientPosterBg(),
      categoryContentCollectionList: const _PagedCategoryCollection(),
      topPositionedContentSliderList: _buildTopPositionedContentSliderList(),
    );
  }

  // 상단 노출 카테고리 리스트
  List<Widget> _buildTopPositionedContentSliderList() {
    return List.generate(
      vm.topPositionedCategory.value?.length ?? 3,
      (categoryIndex) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Obx(
                () => vm.isTopPositionedCollectionLoaded
                    ? Text(
                        vm.selectedTopPositionedCategory(categoryIndex).title,
                        style: AppTextStyle.title2,
                      )
                    : const SkeletonBox(
                        padding: AppInset.vertical4,
                        width: 108,
                        height: 16,
                      ),
              ),
            ),
            AppSpace.size7,
            Obx(
              () => ContentPostSlider(
                height: 160,
                itemCount: vm.topPositionedCategory.value?[categoryIndex].items
                        .length ??
                    5,
                itemBuilder: (context, index) {
                  if (vm.isTopPositionedCollectionLoaded) {
                    final item = vm
                        .selectedTopPositionedCategory(categoryIndex)
                        .items[index];
                    return GestureDetector(
                      onTap: () {
                        final argument = ContentArgumentFormat(
                          contentId: item.contentId,
                          contentType: item.contentType,
                          posterImgUrl: item.posterImgUrl,
                          originId: item.originId,
                          title: item.title,
                        );
                        vm.routeToContentDetail(
                          argument,
                          sectionType: 'topTen',
                        );
                      },
                      child: NewContentPostItem(
                        imgUrl: item.posterImgUrl.prefixTmdbImgPath,
                        title: item.title,
                      ),
                    );
                  } else {
                    return NewContentPostItem.createSkeleton();
                  }
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStackedAppBar() => Padding(
        padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight) +
            AppInset.horizontal16,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Obx(
              () => IgnorePointer(
                child: AnimatedOpacity(
                  opacity: vm.appBarLogoOpacity.value,
                  duration: const Duration(milliseconds: 300),
                  child: SvgPicture.asset('assets/icons/new_logo.svg'),
                ),
              ),
            ),
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
            onTap: () {
              if (vm.isBannerContentsLoaded) {
                final argument = ContentArgumentFormat(
                  contentId: vm.selectedBannerContent!.id,
                  contentType: vm.selectedBannerContent!.type,
                  videoTitle: vm.selectedBannerContent!.description,
                  originId: vm.selectedBannerContent!.originId,
                );
                vm.routeToContentDetail(argument, sectionType: 'banner');
              }
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
                  return const SizedBox();
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
                          vm.selectedBannerContent?.genre ?? '',
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

// 페이징 로직이 적용되어 있는 카테고리 컬렉션 리스트
class _PagedCategoryCollection extends BaseView<HomeViewModel> {
  const _PagedCategoryCollection({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return PagedCategoryListView(
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
            height: 168,
            itemCount: vm.topTenContents?.contentList?.length ?? 5,
            itemBuilder: (context, index) {
              return Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Builder(builder: (context) {
                    if (vm.isTopTenContentsLoaded) {
                      final item = vm.topTenContents!.contentList![index];
                      return GestureDetector(
                        onTap: () {
                          final argument = ContentArgumentFormat(
                            contentId: item.contentId,
                            contentType: item.contentType,
                            originId: item.originId,
                          );
                          vm.routeToContentDetail(argument,
                              sectionType: 'topTen');
                        },
                        child: Stack(children: <Widget>[
                          CachedNetworkImage(
                            height: 140,
                            width: 220,
                            fit: BoxFit.cover,
                            imageUrl: item.posterImgUrl.prefixTmdbImgPath,
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  width: 0.75,
                                  color: AppColor.gray06,
                                ),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => Shimmer(
                              child: Container(
                                color: AppColor.black,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const Center(child: Icon(Icons.error)),
                          ),
                          Positioned(
                            bottom: 0,
                            child: Container(
                              height: 49,
                              width: 220,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color.fromRGBO(15, 15, 15, 0.0),
                                    Color.fromRGBO(15, 15, 15, 0.8),
                                  ],
                                  stops: [0.0, 1.0],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 8,
                            bottom: 6,
                            child: Text(
                              item.title,
                              style: AppTextStyle.title3,
                            ),
                          )
                        ]),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 0.75,
                            color: AppColor.gray06,
                          ),
                        ),
                        child: const SkeletonBox(
                          borderRadius: 4,
                          height: 140,
                          width: 220,
                        ),
                      );
                    }
                  }),
                  Positioned(
                    left: -4,
                    bottom: 13.5,
                    child: Text(
                      '${index + 1}st',
                      style: AppTextStyle.web2,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

/// 2023.05.09
/// [정렬 기준]
/// - 추후 기능을 보완해야겠지만 일단 구독자순으로 상위 20개의 데이터를 불러오는것으로 합의함
///
///  채널 슬라이드
///
class _ChannelSlider extends BaseView<HomeViewModel> {
  const _ChannelSlider({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppInset.left16,
          child: Text(
            '놓치지 말아야 할 리뷰어',
            style: AppTextStyle.title2,
          ),
        ),
        AppSpace.size7,
        SizedBox(
          height: 112.75,
          child: Obx(
            () => ListView.separated(
              padding: AppInset.left18,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (_, __) => AppSpace.size12,
              itemCount: vm.countOfChannelList,
              itemBuilder: (context, index) {
                if (vm.isChannelListLoaded) {
                  return GestureDetector(
                    onTap: () {
                      vm.routeToChannelDetail(vm.channelItem(index));
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border:
                                Border.all(color: AppColor.gray06, width: 0.75),
                          ),
                          child: RoundProfileImg(
                            size: 88,
                            imgUrl: vm.channelItem(index).logoImgUrl,
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 88,
                          child: Text(
                            vm.channelItem(index).name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: AppTextStyle.alert2,
                          ),
                        )
                      ],
                    ),
                  );
                } else {
                  return Column(
                    children: const <Widget>[
                      SkeletonBox(
                        borderRadius: 44,
                        height: 88,
                        width: 88,
                      ),
                      SizedBox(height: 7),
                      SkeletonBox(
                        height: 16,
                        width: 56,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        )
      ],
    );
  }
}
