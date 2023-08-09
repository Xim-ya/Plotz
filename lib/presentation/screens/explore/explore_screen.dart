import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return ExploreScaffold(
      stream: vm(context).exploreContents.stream,
      carouselController: vm(context).swiperController,
      onSwiperChanged: vm(context).onSwiperChanged,
      onContentTapped: vm(context).routeToContentDetail,
      fullSizedPosterImg: _buildFullSizedPosterImg,
      contentInfoView: _buildContentInfoView,
    );
  }

  // 포스터 이미지
  Widget _buildFullSizedPosterImg(ExploreContent? item, BuildContext context) {
    if (item.hasData) {
      return CachedNetworkImage(
        imageUrl: item!.posterImgUrl.prefixTmdbImgPath,
        memCacheWidth: SizeConfig.to.screenWidth.cacheSize(context),
        height: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: AppColor.darkGrey,
        ),
      );
    }
  }

  // 콘텐츠 정보
  Widget _buildContentInfoView(ExploreContent? item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // 제목 & 개봉년도
        Row(
          textBaseline: TextBaseline.ideographic,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          children: <Widget>[
            if (item.hasData)
              Text(
                item!.title,
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
              item?.releaseDate.hasData ?? false
                  ? Formatter.dateToyyMMdd(
                      item!.releaseDate,
                    )
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
          imgUrl: item?.channelLogoImgUrl,
          name: item?.channelName,
          subscriberCount: item?.subscribersCount,
        ),
        AppSpace.size16,
      ],
    );
  }

  @override
  bool get wrapWithSafeArea => false;

  @override
  ExploreViewModel createViewModel(BuildContext context) =>
      locator<ExploreViewModel>();
}
