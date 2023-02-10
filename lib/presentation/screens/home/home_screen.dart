import 'dart:ui';
import 'package:uppercut_fantube/domain/model/content/home/banner.dart';
import 'package:uppercut_fantube/domain/service/local_storage_service.dart';
import 'package:uppercut_fantube/utilities/index.dart';

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
      categoryListWithPostSlider: _buildCategoryListWithPostSlider(),
      body: _buildBody(),
      appBarHeight: vm.appBarHeight,
    );
  }

  /// 카테고리 리스트 - 각 리스트 안에 포스트 슬라이더 위젯이 구성되어 있음.
  List<Widget> _buildCategoryListWithPostSlider() => [
        Obx(
          () => ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: vm.contentListWithCategories.value?.length ?? 0,
            separatorBuilder: (__, _) => AppSpace.size16,
            itemBuilder: (context, index) {
              final item = vm.contentListWithCategories.value![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    // 카테고리 제목
                    child: Text(
                      item.category,
                      style: AppTextStyle.headline3,
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                  AppSpace.size8,
                  // 컨텐츠 리스트 슬라이더
                  ContentPostSlider(
                    height: 180,
                    itemCount: item.contents?.length ?? 0,
                    itemBuilder: (context, index) {
                      final contentItem = item.contents![index];
                      return GestureDetector(
                        onTap: () {
                          final argument = ContentArgumentFormat(
                            contentId: contentItem.contentId,
                            contentType: contentItem.contentType,
                            posterImgUrl: contentItem.posterImgUrl,
                            videoId: contentItem.videoId,
                            title: contentItem.title,
                          );
                          vm.routeToContentDetail(argument);
                        },
                        child:
                            ContentPostItem(imgUrl: contentItem.posterImgUrl),
                      );
                    },
                  ),
                ],
              );
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
          child: GestureDetector(
            onTap: () {
              vm.launchAnotherApp();
            },
            child: Text(
              '순삭 Top10',
              style: AppTextStyle.headline2,
            ),
          ),
        ),
        AppSpace.size6,
        GetBuilder<HomeViewModel>(
          init: vm,
          builder: (_) => ContentPostSlider(
            height: 200,
            itemCount: vm.topTenContents.contentList?.length ?? 0,
            itemBuilder: (context, index) {
              final item = vm.topTenContents.contentList![index];
              return GestureDetector(
                onTap: () {
                  final argument = ContentArgumentFormat(
                    contentId: item.contentId,
                    contentType: item.contentType,
                    posterImgUrl: item.posterImgUrl,
                  );
                  vm.routeToContentDetail(argument);
                },
                child: ContentPostItem(
                  imgUrl: vm.topTenContents.contentList![index].posterImgUrl
                      .prefixTmdbImgPath,
                ),
              );
            },
          ),
        )
      ];

  // 맨 상단에 노출되어 있는 컨텐츠 슬라이더 - (컨텐츠 제목, 내용, 유튜브썸네일 이미지로 구성)
  // TODO : Skeleton 처리 필요
  Widget _buildTopBannerSlider() => GetBuilder<HomeViewModel>(
        init: vm,
        builder: (_) {
          return CarouselSlider.builder(
            carouselController: vm.carouselController,
            itemCount: vm.topExposedContentList?.length ?? 0,
            options: CarouselOptions(
              onPageChanged: (index, _) {
                vm.onBannerSliderSwiped(index);
              },
              initialPage: 0,
              enableInfiniteScroll: false,
              viewportFraction: 0.93,
              aspectRatio: 337 / 276,
            ),
            itemBuilder:
                (BuildContext context, int itemIndex, int pageViewIndex) {
              final BannerItem item = vm.topExposedContentList![itemIndex];

              /// Top Content Section
              return GestureDetector(
                onTap: () {
                  print(vm.topExposedContentList!.length);
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      GestureDetector(
                        child: Text(
                          item.title ?? '-',
                          style: AppTextStyle.headline2
                              .copyWith(color: Colors.white),
                        ),
                      ),
                      AppSpace.size2,
                      Text(
                        '${item.description}\n',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: AppTextStyle.headline3
                            .copyWith(color: AppColor.lightGrey),
                      ),
                      AppSpace.size8,
                      // 유튜브 썸네일 이미지
                      VideoThumbnailImgWithPlayerBtn(
                        onPlayerBtnClicked: () {
                          final argument = ContentArgumentFormat(
                            contentId: item.id,
                            contentType: item.type,
                            posterImgUrl: item.backdropImgUrl,
                            thumbnailUrl: item.imgUrl,
                            videoId: item.videoId,
                          );
                          vm.routeToContentDetail(argument);
                        },
                        posterImgUrl: item.imgUrl,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      );

  // 배경 위젯 - Poster + Gradient Image 로 구성됨.
  List<Widget> _buildStackedGradientPosterBg() => [
        GetBuilder<HomeViewModel>(
          init: vm,
          builder: (_) {
            if (vm.isTopExposedContentListLoaded) {
              return CachedNetworkImage(
                width: double.infinity,
                fit: BoxFit.fitWidth,
                imageUrl: vm
                    .selectedTopExposedContent.backdropImgUrl.prefixTmdbImgPath,
                errorWidget: (context, url, error) => const Icon(Icons.error),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
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
                LocalStorageService.to.deleteData(fieldName: 'banner');
                // vm.loadBannerContents();
                // vm.testResponseResult();
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
