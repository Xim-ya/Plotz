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
    );
  }

  Widget buildCarouselBuilder() {
    return Obx(
      () => CarouselSlider.builder(
          itemCount: vm.exploreContentList.value?.length ?? 0,
          options: CarouselOptions(
            onPageChanged: (index, reason) {
              vm.swiperIndex(index);
              vm.scannedAndUpdateContentInfo();
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
            return Stack(
              children: [
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
                        ...buildChannelInfoView(contentItem),
                        ...buildContentInfoView(),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
    );
  }

  // 채널 정보
  List<Widget> buildChannelInfoView(ExploreContent item) => [
        Obx(
          () => GestureDetector(
            onTap: () {
              print('${item.youtubeInfo.value?.channelName ?? "제목 없음"}');
              print('${item.detailInfo.value?.title ?? "제목 없음"}');
            },
            child: ChannelInfoView(
              channelImgUrl: vm.channelImgUrl,
              channelName:
                  '${item.idInfo.videoId} ++ ${item.detailInfo.value?.title ?? "null"}',
              subscriberCount: vm.subscriberCount,
            ),
          ),
        ),
        AppSpace.size20,
      ];

  // 컨텐츠 정보
  List<Widget> buildContentInfoView() => [
        // 제목 & 개봉년도
        Row(
          children: <Widget>[
            Obx(
              () => vm.headerTitle.hasData
                  ? Text(vm.headerTitle!, style: AppTextStyle.headline2)
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
                vm.releaseDate.hasData
                    ? Formatter.dateToyyMMdd(vm.releaseDate!)
                    : '-',
                style: AppTextStyle.alert2,
              ),
            )
          ],
        ),
        AppSpace.size6,
        // 컨텐츠 설명
        SizedBox(
          width: SizeConfig.to.screenWidth - 32,
          child: Text(
            '결말에서 당신의 심장을 찢겠습니다 2 | 어퍼컷 리뷰 중 가장 반응이 좋았던 《11.22.63》',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.title1,
          ),
        ),
        AppSpace.size24,
      ];

  // 컨텐츠 (포스터) 이미지
  Widget buildBackdropImg() => CachedNetworkImage(
        imageUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg'.prefixTmdbImgPath,
        height: double.infinity,
        fit: BoxFit.cover,
      );

  @override
  bool get wrapWithSafeArea => false;
}
