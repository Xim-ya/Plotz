import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return ExploreSwiperItemScaffold(
      backdropImg: buildBackdropImg(),
      carouselBuilder: const _VerticalSwiper(),
      actionButtons: const SizedBox(),
    );
  }

  // 채널 정보
  List<Widget> buildChannelInfoView(ExploreContent? item) => [
        ChannelInfoView(
          imgUrl: item?.channelLogoImgUrl,
          name: item?.channelName,
          subscriberCount: item?.subscribersCount,
        ),
        AppSpace.size20,
      ];

  // 컨텐츠 정보
  List<Widget> buildContentInfoView(ExploreContent? item) => [
        // 제목 & 개봉년도
        Row(
          children: <Widget>[
            if (item.hasData)
              Text(item!.title, style: AppTextStyle.headline2)
            else
              const SkeletonBox(
                height: 28,
                width: 40,
              ),
            AppSpace.size6,
            Text(
              item?.releaseDate.hasData ?? false
                  ? Formatter.dateToyyMMdd(item!.releaseDate)
                  : '',
              style: AppTextStyle.alert2,
            ),
          ],
        ),
        AppSpace.size6,
        // 컨텐츠 설명
        if (item?.videoTitle != null)
          SizedBox(
            width: SizeConfig.to.screenWidth - 32,
            child: Text(
              item!.videoTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.title1,
            ),
          )
        else
          SkeletonBox(
            height: 22,
            width: SizeConfig.to.screenWidth - 32,
            borderRadius: 2,
          ),
        AppSpace.size24,
      ];

  // 컨텐츠 (포스터) 이미지
  Widget buildBackdropImg() => Container();

  @override
  bool get wrapWithSafeArea => false;

  @override
  ExploreViewModel createViewModel(BuildContext context) =>
      locator<ExploreViewModel>();
}

class _VerticalSwiper extends BaseView<ExploreViewModel> {
  const _VerticalSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<ExploreContent>>(
      stream: vm(context).exploreContents.stream,
      builder: (context, snapshot) {
        return CarouselSlider.builder(
          carouselController: vm(context).swiperController,
          itemCount: snapshot.data?.length ?? 1,
          options: CarouselOptions(
            onPageChanged: (index, _) {
              vm(context).onSwiperChanged(index);
            },
            disableCenter: true,
            height: double.infinity,
            scrollDirection: Axis.vertical,
            enableInfiniteScroll: false,
            viewportFraction: 1,
          ),
          itemBuilder:
              (BuildContext context, int parentIndex, int pageViewIndex) {
            final contentItem = snapshot.data?[pageViewIndex];
            return GestureDetector(
              onTap: () {
                if (snapshot.data == null) return;
                vm(context).routeToContentDetail(pageViewIndex);
              },
              child: Stack(
                children: [
                  if (snapshot.data.hasData)
                    CachedNetworkImage(
                      imageUrl: contentItem!.posterImgUrl.prefixTmdbImgPath,
                      memCacheWidth:
                          SizeConfig.to.screenWidth.cacheSize(context),
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  else
                    const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.darkGrey,
                      ),
                    ),
                  // Align(
                  //   alignment: Alignment.topCenter,
                  //   child: buildBackdropImg(),
                  // ),
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
          },
        );
      },
    );
  }

  // 컨텐츠 정보
  List<Widget> buildContentInfoView(ExploreContent? item) => [
        // 제목 & 개봉년도
        Row(
          children: <Widget>[
            if (item.hasData)
              Text(item!.title, style: AppTextStyle.headline2)
            else
              const SkeletonBox(
                height: 28,
                width: 40,
              ),
            AppSpace.size6,
            Text(
              item?.releaseDate.hasData ?? false
                  ? Formatter.dateToyyMMdd(item!.releaseDate)
                  : '',
              style: AppTextStyle.alert2,
            ),
          ],
        ),
        AppSpace.size6,
        // 컨텐츠 설명
        if (item?.videoTitle != null)
          SizedBox(
            width: SizeConfig.to.screenWidth - 32,
            child: Text(
              item!.videoTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.title1,
            ),
          )
        else
          SkeletonBox(
            height: 22,
            width: SizeConfig.to.screenWidth - 32,
            borderRadius: 2,
          ),
        AppSpace.size24,
      ];

  // 채널 정보
  List<Widget> buildChannelInfoView(ExploreContent? item) => [
        ChannelInfoView(
          imgUrl: item?.channelLogoImgUrl,
          name: item?.channelName,
          subscriberCount: item?.subscribersCount,
        ),
        AppSpace.size20,
      ];
}
