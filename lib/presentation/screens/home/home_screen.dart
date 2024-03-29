import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/home/newly_added_content_info.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class HomeScreen extends BaseScreen<HomeViewModel> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return HomeScaffold(
      stackedTopGradient: _buildStackedTopGradient(context),
      stackedAppBar: _buildStackedAppBar(context),
      topBannerSlider: const _BannerSlider(),
      newlyAddedContentSlider: const _NewlyAddedContentSlider(),
      topTenSlider: const _TopTenContentSlider(),
      channelSlider: const _ChannelSlider(),
      scrollController: vm(context).scrollController,
      categoryContentCollectionList: const _PagedCategoryCollection(),
      topPositionedContentSliderList:
          _buildTopPositionedContentSliderList(context),
    );
  }

  // 상단 노출 카테고리 리스트
  List<Widget> _buildTopPositionedContentSliderList(BuildContext context) {
    return List.generate(
      vmS<int>(context, (vm) => vm.topPositionedCategory?.length ?? 2),
      (categoryIndex) {
        return Consumer<HomeViewModel>(
          builder: (context, value, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'data',
                  style: AppTextStyle.alert1.copyWith(
                    color: Theme.of(context).dividerColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: value.isTopPositionedCollectionLoaded
                      ? Text(
                          value
                              .selectedTopPositionedCategory(categoryIndex)
                              .title,
                          style: AppTextStyle.title2,
                        )
                      : const SkeletonBox(
                          padding: AppInset.vertical1,
                          width: 92,
                          height: 18,
                        ),
                ),
                AppSpace.size7,
                ContentPostSlider(
                  height: 161,
                  itemCount: value
                          .topPositionedCategory?[categoryIndex].items.length ??
                      5,
                  itemBuilder: (context, index) {
                    if (value.isTopPositionedCollectionLoaded) {
                      final item = value
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
                          value.routeToContentDetail(
                            context,
                            argument,
                            sectionType: 'topTen',
                          );
                        },
                        child: ContentPosterItemView(
                          imgUrl: item.posterImgUrl.prefixTmdbImgPath,
                          title: item.title,
                        ),
                      );
                    } else {
                      return ContentPosterItemView.createSkeleton();
                    }
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildStackedAppBar(BuildContext context) => Padding(
        padding: EdgeInsets.only(top: SizeConfig.to.statusBarHeight) +
            AppInset.horizontal16,
        child: IgnorePointer(
          child: Selector<HomeViewModel, bool>(
            selector: (context, vm) => vm.isScrolledOnPosition,
            builder: (_, isScrolledOnPosition, __) => AnimatedOpacity(
              opacity: isScrolledOnPosition ? 0 : 1,
              duration: const Duration(milliseconds: 300),
              child: SvgPicture.asset('assets/icons/new_logo.svg'),
            ),
          ),
        ),
      );

  Widget _buildStackedTopGradient(BuildContext context) => IgnorePointer(
      child: Selector<HomeViewModel, bool>(
          selector: (context, vm) => vm.isScrolledOnPosition,
          builder: (_, isScrolledOnPosition, __) => AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                height: isScrolledOnPosition ? 172 : 88,
                decoration:
                    const BoxDecoration(gradient: AppGradient.topToBottom),
              )));

  @override
  HomeViewModel createViewModel(BuildContext context) =>
      locator<HomeViewModel>();
}

/// 최근 추가된 콘텐츠 슬라이더
class _NewlyAddedContentSlider extends BaseView<HomeViewModel> {
  const _NewlyAddedContentSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<HomeViewModel, NewlyAddedContentInfo?>(
      selector: (context, vm) => vm.newlyAddedContentInfo,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          '새로 올라온 콘텐츠',
          style: AppTextStyle.title2,
        ),
      ),
      builder: (context, value, title) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            title!,
            AppSpace.size7,
            ContentPostSlider(
              height: 161,
              itemCount: value?.contents.length ?? 5,
              itemBuilder: (context, index) {
                if (value.hasData) {
                  final item = value!.contents[index];
                  return GestureDetector(
                    onTap: () {
                      final argument = ContentArgumentFormat(
                        contentId: item.id,
                        contentType: item.contentType,
                        posterImgUrl: item.posterImgUrl,
                        originId: item.originId,
                        title: item.title,
                      );
                      vm(context).routeToContentDetail(
                        context,
                        argument,
                        sectionType: 'newlyAdded',
                      );
                    },
                    child: ContentPosterItemView(
                      imgUrl: item.posterImgUrl.prefixTmdbImgPath,
                      title: item.title,
                    ),
                  );
                } else {
                  return ContentPosterItemView.createSkeleton();
                }
              },
            ),
          ],
        );
      },
    );
  }
}

/// 상단 배너 슬라이더
class _BannerSlider extends BaseView<HomeViewModel> {
  const _BannerSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Selector<HomeViewModel, BannerModel?>(
          selector: (context, vm) => vm.bannerContents,
          builder: (context, BannerModel? bannerModel, child) {
            return GestureDetector(
              onTap: () {
                if (bannerModel.hasData) {
                  vm(context).routeToBannerContentDetail(context);
                }
              },
              child: CarouselSlider.builder(
                carouselController: vm(context).carouselController,
                itemCount: bannerModel?.contentList.length ?? 2,
                options: CarouselOptions(
                  aspectRatio: 375 / 500,
                  autoPlay: true,
                  autoPlayAnimationDuration: const Duration(milliseconds: 1800),
                  onPageChanged: (index, _) {
                    vm(context).onBannerSliderSwiped(index);
                  },
                  onScrolled: vm(context).onBannerSliderScrolled,
                  viewportFraction: 1,
                ),
                itemBuilder:
                    (BuildContext context, int itemIndex, int pageViewIndex) {
                  if (bannerModel.hasData) {
                    final BannerItem item = bannerModel!.contentList[itemIndex];
                    return CachedNetworkImage(
                      memCacheHeight:
                          SizeConfig.to.screenWidth.cacheSize(context) *
                              375 ~/
                              500,
                      imageUrl: item.imgUrl,
                      fit: BoxFit.fitHeight,
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            );
          },
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
                    Color.fromRGBO(0, 0, 0, 0),
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0, 0.8),
                    Color.fromRGBO(0, 0, 0, 1),
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
                IgnorePointer(
                  child: Consumer<HomeViewModel>(builder: (context, vm, __) {
                    return StreamBuilder<double>(
                      stream: vm.bannerInfoOpacity.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return AnimatedOpacity(
                            duration: const Duration(milliseconds: 100),
                            opacity: snapshot.data!,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: SizeConfig.to.screenWidth - 32,
                                  child: Center(
                                    child: Text(
                                      vmS(
                                          context,
                                          (value) =>
                                              value.selectedBannerContent
                                                  ?.description ??
                                              ''),
                                      style: AppTextStyle.title3.copyWith(
                                          color: AppColor.main,
                                          letterSpacing: -0.2),
                                    ),
                                  ),
                                ),
                                AppSpace.size2,
                                Text(
                                  vmS(
                                      context,
                                      (value) =>
                                          value.selectedBannerContent?.title ??
                                          ''),
                                  style: AppTextStyle.web3
                                      .copyWith(letterSpacing: -0.2),
                                ),
                                AppSpace.size4,
                                Text(
                                  vmS(
                                      context,
                                      (value) =>
                                          value.selectedBannerContent?.genre ??
                                          ''),
                                  style: AppTextStyle.alert2.copyWith(
                                      color: AppColor.gray02,
                                      letterSpacing: -0.2),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    );
                  }),
                ),
                AppSpace.size12,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Consumer<HomeViewModel>(
                    builder: (context, vm, _) {
                      return DotsIndicator(
                        dotsCount: vmS<int>(
                            context, (vm) => vm.bannerContentList?.length ?? 4),
                        position: vmS<int>(
                                context, (vm) => vm.bannerContentsSliderIndex)
                            .toDouble(),
                        decorator: const DotsDecorator(
                          spacing: EdgeInsets.symmetric(horizontal: 4),
                          size: Size(4, 4),
                          activeSize: Size(4, 4),
                          color: AppColor.gray04,
                          // Inactive color
                          activeColor: AppColor.gray01,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// 페이징 로직이 적용되어 있는 카테고리 컬렉션 리스트
class _PagedCategoryCollection extends BaseView<HomeViewModel> {
  const _PagedCategoryCollection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PagedCategoryListView(
      pagingController: vm(context).pagingController,
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
            vm(context).routeToContentDetail(context, argument,
                sectionType: 'category');
          },
        );
      },
    );
  }
}

class _TopTenContentSlider extends BaseView<HomeViewModel> {
  const _TopTenContentSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        Selector<HomeViewModel, List<ContentPosterShell>?>(
          selector: (context, vm) => vm.topTenContents?.contentList,
          builder: (context, itemList, __) {
            return ContentPostSlider(
              height: 168,
              itemCount: itemList?.length ?? 5,
              itemBuilder: (context, index) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: <Widget>[
                    Builder(builder: (context) {
                      if (itemList.hasData) {
                        final item = itemList![index];
                        return GestureDetector(
                          onTap: () {
                            final argument = ContentArgumentFormat(
                              contentId: item.contentId,
                              contentType: item.contentType,
                              originId: item.originId,
                            );
                            vm(context).routeToContentDetail(
                              context,
                              argument,
                              sectionType: 'topTen',
                            );
                          },
                          child: Stack(children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(4),
                              child: CachedNetworkImage(
                                memCacheWidth: 220.cacheSize(context),
                                height: 140,
                                width: 220,
                                fit: BoxFit.cover,
                                imageUrl: item.posterImgUrl.prefixTmdbImgPath,
                                placeholder: (context, url) =>
                                    const SkeletonBox(),
                                errorWidget: (context, url, error) =>
                                    const Center(child: Icon(Icons.error)),
                              ),
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
                                      Color.fromRGBO(0, 0, 0, 0.0),
                                      Color.fromRGBO(0, 0, 0, 0.8),
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
                                item.title!,
                                style: AppTextStyle.title3,
                              ),
                            )
                          ]),
                        );
                      } else {
                        return const SkeletonBox(
                          height: 140,
                          width: 220,
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
            );
          },
        )
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
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: AppInset.left16,
          child: Text(
            '놓치지 말아야 할 리뷰 채널',
            style: AppTextStyle.title2,
          ),
        ),
        AppSpace.size7,
        SizedBox(
          height: 113.75,
          child: Selector<HomeViewModel, List<ChannelModel>?>(
            selector: (context, vm) => vm.channelList,
            builder: (context, itemList, _) {
              return ListView.separated(
                padding: AppInset.left18,
                scrollDirection: Axis.horizontal,
                separatorBuilder: (_, __) => AppSpace.size12,
                itemCount: itemList?.length ?? 0,
                itemBuilder: (context, index) {
                  if (itemList.hasData) {
                    return GestureDetector(
                      onTap: () {
                        vm(context).routeToChannelDetail(context,
                            selectedIndex: index);
                      },
                      child: Column(
                        children: <Widget>[
                          RoundProfileImg(
                            size: 88,
                            imgUrl: vm(context).channelItem(index).logoImgUrl,
                          ),
                          const SizedBox(height: 5),
                          SizedBox(
                            width: 88,
                            child: Text(
                              vm(context).channelItem(index).name,
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
                    return const Column(
                      children: <Widget>[
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
              );
            },
          ),
        )
      ],
    );
  }
}
