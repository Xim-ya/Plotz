import 'package:uppercut_fantube/presentation/common/skeleton_box.dart';
import 'package:uppercut_fantube/presentation/common/youtube/channel_info_view.dart';
import 'package:uppercut_fantube/presentation/screens/explore/explore_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreScreen extends BaseScreen<ExploreViewModel> {
  const ExploreScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      height: double.infinity,
      child: CarouselSlider.builder(
        itemCount: 4,
        options: CarouselOptions(
          disableCenter: true,
          height: double.infinity,
          scrollDirection: Axis.vertical,
          enableInfiniteScroll: false,
          viewportFraction: 1,
        ),
        itemBuilder:
            (BuildContext context, int parentIndex, int pageViewIndex) {
          /// Top Content Section
          return Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: CachedNetworkImage(
                  imageUrl: "/ggFHVNu6YYI5L9pCfOacjizRGt.jpg".prefixTmdbImgPath,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
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
                    children: <Widget>[
                      Obx(
                        () => ChannelInfoView(
                          channelImgUrl: vm.channelImgUrl,
                          channelName: vm.channelName,
                          subscriberCount: vm.subscriberCount,
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     // 채널 프로필 이미지
                      //     if (vm.channelImgUrl.hasData)
                      //       RoundProfileImg(
                      //         size: 48,
                      //         imgUrl: vm.channelImgUrl,
                      //       )
                      //     else
                      //       const SkeletonBox(
                      //         width: 48,
                      //         height: 48,
                      //         borderRadius: 100,
                      //       ),
                      //     AppSpace.size10,
                      //     // 채널명
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: <Widget>[
                      //         if (vm.channelName.hasData)
                      //           Text(
                      //             vm.channelName!,
                      //             style: AppTextStyle.headline3,
                      //           )
                      //         else ...[
                      //           const SkeletonBox(
                      //             width: 80,
                      //             height: 20,
                      //           ),
                      //           AppSpace.size2,
                      //         ],
                      //         if (vm.subscriberCount.hasData)
                      //           Text(
                      //             '구독자 ${vm.subscriberCount}명',
                      //             style: AppTextStyle.body1
                      //                 .copyWith(color: AppColor.lightGrey),
                      //           )
                      //         else
                      //           const SkeletonBox(
                      //             width: 180,
                      //             height: 22,
                      //           ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      AppSpace.size20,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
