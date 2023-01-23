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
          onIconTapped: vm.reFetchExploreContent,
        ),
      ],
    );
  }

  Widget buildCarouselBuilder() {
    return Obx(
      () => CarouselSlider.builder(
          carouselController: vm.swiperController,
          itemCount: vm.exploreContentList.value?.length ?? 0,
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
            final contentItem = vm.exploreContentList.value![pageViewIndex];
            return GestureDetector(
              onTap: () {
                  vm.routeToContentDetail(ContentArgumentFormat(
                    contentId: contentItem.idInfo.contentId,
                    videoId: contentItem.idInfo.videoId,
                    contentType: contentItem.idInfo.contentType,
                    posterImgUrl: contentItem.detailInfo?.posterImg,
                    title: contentItem.detailInfo?.title,
                  ));

              },
              child: Stack(
                children: [
                  Obx(
                    () => contentItem.detailInfo.hasData
                        ? CachedNetworkImage(
                            imageUrl: contentItem
                                    .detailInfo?.posterImg?.prefixTmdbImgPath ??
                                '',
                            height: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : const Center(
                            child: CircularProgressIndicator(
                              color: AppColor.darkGrey,
                            ),
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
          }),
    );
  }

  // 채널 정보
  List<Widget> buildChannelInfoView(ExploreContent item) => [
        Obx(
          () => GestureDetector(
            onTap: () {},
            child: ChannelInfoView(
              channelImgUrl: item.youtubeInfo?.channelImgUrl,
              channelName: item.youtubeInfo?.channelName,
              subscriberCount: item.youtubeInfo?.subscribers,
            ),
          ),
        ),
        AppSpace.size20,
      ];

  // 컨텐츠 정보
  List<Widget> buildContentInfoView(ExploreContent item) => [
        // 제목 & 개봉년도
        Row(
          children: <Widget>[
            Obx(
              () => item.detailInfo.hasData
                  ? Text(item.detailInfo!.title, style: AppTextStyle.headline2)
                  : Shimmer(
                      color: AppColor.lightGrey,
                      child: const SizedBox(
                        height: 28,
                        width: 40,
                      ),
                    ),
            ),
            AppSpace.size6,
            Obx(
              () => Text(
                item.detailInfo?.releaseDate.hasData ?? false
                    ? Formatter.dateToyyMMdd(item.detailInfo!.releaseDate!)
                    : '-',
                style: AppTextStyle.alert2,
              ),
            )
          ],
        ),
        AppSpace.size6,
        // 컨텐츠 설명
        Obx(
          () => item.youtubeInfo.hasData
              ? SizedBox(
                  width: SizeConfig.to.screenWidth - 32,
                  child: Text(
                    item.youtubeInfo!.videoTitle,
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
