import 'package:uppercut_fantube/presentation/common/button/linear_background_bottom_floating_btn.dart';
import 'package:uppercut_fantube/presentation/common/image/linear_layered_poster_img.dart';
import 'package:uppercut_fantube/presentation/common/youtube/channel_info_view.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ConfirmQurationScreen extends BaseView<RegisterViewModel> {
  const ConfirmQurationScreen({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return Stack(
      children: <Widget>[
        SingleChildScrollView(
          child: Padding(
            padding: AppInset.horizontal16 + const EdgeInsets.only(bottom: 200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // 리딩 문구
                Padding(
                  padding: AppInset.top10 + AppInset.bottom16,
                  child: Text(
                    '입력된 컨텐츠\n정보가 맞는지 확인해주세요!',
                    style: AppTextStyle.headline1,
                  ),
                ),
                AppSpace.size8,

                // 등록 컨텐츠 정보
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: vm.responsiveHInset),
                  child: Stack(
                    children: <Widget>[
                      // 컨텐츠 포스터 이미지
                      Obx(
                        () => LinearLayeredPosterImg(
                          borderRadius: 12,
                          aspectRatio: 273 / 412,
                          imgUrl: vm.posterImgUrl,
                          linearColor: Colors.black,
                          linearStep: const [0.0, 0.36, 1.0],
                        ),
                      ),

                      // 채널 정보
                      Obx(
                        () => Positioned(
                          left: 12,
                          bottom: 14,
                          child: ChannelInfoView(
                            imgSize: 40,
                            imgUrl: vm.channelImgUrl,
                            name: vm.channelName,
                            nameFontSize: 16,
                            subscriberCount: vm.subscriberCount,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppSpace.size10,

                // 컨텐츠 상세 정보
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Obx(
                        () => Text(
                          vm.contentTitle ?? '',
                          style: AppTextStyle.title1,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      AppSpace.size2,
                      Obx(() {
                        if (vm.releaseDate.hasData) {
                          return Text(Formatter.dateToyyyyMMdd(vm.releaseDate!),
                              style: AppTextStyle.body2
                                  .copyWith(color: AppColor.lightGrey));
                        } else {
                          return const SizedBox();
                        }
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: Stack(
            children: [
              Positioned(
                bottom: 0,
                child: Container(
                  height: 72,
                  width: SizeConfig.to.screenWidth,
                  color: AppColor.black,
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    bottom: SizeConfig.to.responsiveBottomInset),
                child: LinearBgBottomFloatingBtn(
                  text: '다음',
                  onTap: vm.onFloatingStepBtnTapped,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
