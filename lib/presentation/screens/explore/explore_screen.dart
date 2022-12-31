import 'package:uppercut_fantube/presentation/common/youtube/channel_info_view.dart';
import 'package:uppercut_fantube/presentation/screens/explore/explore_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/explore/localWidget/explore_swiper_item_scaffold.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return ExploreSwiperItemScaffold(
      backdropImg: buildBackdropImg(),
      contentInfoView: buildContentInfoView(),
      channelInfoView: buildContentInfoView(),
    );
  }

  List<Widget> buildChannelInfoView() => [
        // 채널 정보
        Obx(
          () => ChannelInfoView(
            channelImgUrl: vm.channelImgUrl,
            channelName: vm.channelName,
            subscriberCount: vm.subscriberCount,
          ),
        ),
        AppSpace.size20,
      ];

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
            '수십 년 전 잠적한 전직 CIA 요원 댄 체이스. 과거의 비밀을 안고 은둔한 채 살아가던 중 결국 정체가 탄로 난다. 하지만 미래를 위해서 더 이상 숨어 살 수 없는 그는 과거의 매듭을 풀고자 하는데.',
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.title1,
          ),
        ),
        AppSpace.size24,
      ];

  Widget buildBackdropImg() => CachedNetworkImage(
        imageUrl: '/ggFHVNu6YYI5L9pCfOacjizRGt.jpg'.prefixTmdbImgPath,
        height: double.infinity,
        fit: BoxFit.cover,
      );
}
