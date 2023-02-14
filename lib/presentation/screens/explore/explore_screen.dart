import 'package:uppercut_fantube/domain/model/content/explore/explore_content_model.dart';
import 'package:uppercut_fantube/presentation/common/youtube/channel_info_view.dart';
import 'package:uppercut_fantube/presentation/screens/explore/explore_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/explore/localWidget/explore_swiper_item_scaffold.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return ExploreSwiperItemScaffold(
      backdropImg: buildBackdropImg(),
      carouselBuilder: buildCarouselBuilder(),
      actionButtons: buildActionButtons(),
    );
  }

  Widget buildActionButtons() {
    return Row(
      children: [
        IconInkWellButton.assetIcon(
          iconPath: 'assets/icons/search.svg',
          size: 40,
          onIconTapped: vm.routeToSearch,
        ),
        IconInkWellButton.packageIcon(
          icon: Icons.refresh,
          size: 28,
          onIconTapped: vm.test,
        ),
      ],
    );
  }

  Widget buildCarouselBuilder() {
    return GetBuilder<ExploreViewModel>(
        init: vm,
        builder: (_) {
          return CarouselSlider.builder(
              carouselController: vm.swiperController,
              itemCount: vm.exploreContents?.length ?? 0,
              options: CarouselOptions(
                onPageChanged: (index, _) {
                  vm.onSwiperChanged(index);
                },
                disableCenter: true,
                height: double.infinity,
                scrollDirection: Axis.vertical,
                enableInfiniteScroll: false,
                viewportFraction: 1,
              ),
              itemBuilder:
                  (BuildContext context, int parentIndex, int pageViewIndex) {
                final contentItem = vm.exploreContents![pageViewIndex];
                return GestureDetector(
                  onTap: () {
                    vm.routeToContentDetail(ContentArgumentFormat(
                      contentId: contentItem.id,
                      videoId: contentItem.videoId,
                      contentType: contentItem.type,
                      posterImgUrl: contentItem.posterImgUrl,
                      title: contentItem.title,
                    ));
                  },
                  child: Stack(
                    children: [
                      vm.isContentLoaded
                          ? CachedNetworkImage(
                              imageUrl:
                                  contentItem.posterImgUrl.prefixTmdbImgPath,
                              height: double.infinity,
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: CircularProgressIndicator(
                                color: AppColor.darkGrey,
                              ),
                            ),
                      Align(
                        alignment: Alignment.topCenter,
                        child: buildBackdropImg(),
                      ),
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
                              stops: <double>[0.06, 0.3, 0.92],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: AppInset.horizontal16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              ...buildContentInfoView(contentItem),
                              ...buildChannelInfoView(contentItem),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              });
        });
  }

  // 채널 정보
  List<Widget> buildChannelInfoView(ExploreContentItem? item) => [
        Obx(
          () => GestureDetector(
            onTap: () {},
            child: ChannelInfoView(
              imgUrl: item?.youtubeInfo.value?.channelImgUrl,
              name: item?.youtubeInfo.value?.channelName,
              subscriberCount: item?.youtubeInfo.value?.subscribers,
            ),
          ),
        ),
        AppSpace.size20,
      ];

  // 컨텐츠 정보
  List<Widget> buildContentInfoView(ExploreContentItem? item) => [
        // 제목 & 개봉년도
        Row(
          children: <Widget>[
            if (item.hasData)
              Text(item!.title, style: AppTextStyle.headline2)
            else
              Shimmer(
                color: AppColor.lightGrey,
                child: const SizedBox(
                  height: 28,
                  width: 40,
                ),
              ),
            AppSpace.size6,
            Text(
              item?.releaseDate.hasData ?? false
                  ? Formatter.dateToyyMMdd(item!.releaseDate)
                  : '-',
              style: AppTextStyle.alert2,
            ),
          ],
        ),
        AppSpace.size6,
        // 컨텐츠 설명
        Obx(
          () => item?.youtubeInfo.value != null
              ? SizedBox(
                  width: SizeConfig.to.screenWidth - 32,
                  child: Text(
                    item!.youtubeInfo.value!.videoTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.title1,
                  ),
                )
              : SkeletonBox(
                  height: 22,
                  width: SizeConfig.to.screenWidth - 32,
                  borderRadius: 2,
                ),
        ),
        AppSpace.size24,
      ];

  // 컨텐츠 (포스터) 이미지
  Widget buildBackdropImg() => Container();

  @override
  bool get wrapWithSafeArea => false;
}
