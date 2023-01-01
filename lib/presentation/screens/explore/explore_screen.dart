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
      contentInfoView: buildContentInfoView(),
      channelInfoView: buildChannelInfoView(),
    );
  }

  // 채널 정보
  List<Widget> buildChannelInfoView() => [
        Obx(
          () => ChannelInfoView(
            channelImgUrl: vm.channelImgUrl,
            channelName: vm.channelName,
            subscriberCount: vm.subscriberCount,
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
