import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
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
                  // 하단 Gradient Container
                  Positioned(
                    bottom: 0,
                    child: Container(
                      height: SizeConfig.to.ratioHeight(208),
                      width: SizeConfig.to.screenWidth,
                      decoration: const BoxDecoration(
                          gradient: AppGradient.exBottomToTop),
                    ),
                  ),

                  // 상단 StatusBar Container
                  Positioned(
                    top: 0,
                    child: Container(
                      height: SizeConfig.to.statusBarHeight,
                      width: SizeConfig.to.screenWidth,
                      color: AppColor.black,
                    ),
                  ),

                  // 상단 Gradient Container
                  Positioned(
                    top: SizeConfig.to.statusBarHeight,
                    child: Container(
                      height: SizeConfig.to.ratioHeight(88),
                      width: SizeConfig.to.screenWidth,
                      decoration: const BoxDecoration(
                        gradient: AppGradient.exTopBottom,
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
                          // 제목 & 개봉년도
                          Row(
                            textBaseline: TextBaseline.ideographic,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            children: <Widget>[
                              if (contentItem.hasData)
                                Text(
                                  contentItem!.title,
                                  style: AppTextStyle.headline2,
                                )
                              else
                                const SkeletonBox(
                                  padding: AppInset.vertical2,
                                  height: 28,
                                  width: 40,
                                ),
                              AppSpace.size6,
                              Text(
                                contentItem?.releaseDate.hasData ?? false
                                    ? Formatter.dateToyyMMdd(
                                        contentItem!.releaseDate,
                                      )
                                    : '',
                                style: AppTextStyle.alert2,
                              ),
                            ],
                          ),
                          AppSpace.size6,
                          // 컨텐츠 설명
                          if (contentItem?.videoTitle != null)
                            SizedBox(
                              width: SizeConfig.to.screenWidth - 32,
                              child: Text(
                                contentItem!.videoTitle,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.body1,
                              ),
                            )
                          else
                            SkeletonBox(
                              height: 18,
                              width: SizeConfig.to.screenWidth * 0.6,
                              padding: AppInset.vertical2,
                              borderRadius: 2,
                            ),
                          AppSpace.size14,
                          ChannelInfoView(
                            imgSize: 32,
                            imgUrl: contentItem?.channelLogoImgUrl,
                            name: contentItem?.channelName,
                            subscriberCount: contentItem?.subscribersCount,
                          ),
                          AppSpace.size16,
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

  @override
  bool get wrapWithSafeArea => false;

  @override
  ExploreViewModel createViewModel(BuildContext context) =>
      locator<ExploreViewModel>();
}
