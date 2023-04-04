import 'package:soon_sak/presentation/screens/register/localWidget/confirm_curation_page_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';

class ConfirmCurationPageView extends BaseView<RegisterViewModel> {
  const ConfirmCurationPageView({Key? key}) : super(key: key);

  @override
  Widget buildView(BuildContext context) {
    return ConfirmCurationPageScaffold(
        leadingText: '입력된 컨텐츠\n정보가 맞는지 확인해주세요!',
        responsiveHInset: vm.responsiveHInset,
        posterImg: _buildPosterImg(),
        channelInfoView: _buildChannelInfoView(),
        contentDetailInfoView: _buildContentDetailInfoView(),
        bottomFixedBtn: _buildBottomFixedBtn());
  }

  Widget _buildPosterImg() => Obx(
        () => LinearLayeredPosterImg(
          aspectRatio: 273 / 412,
          imgUrl: vm.posterImgUrl,
          linearColor: Colors.black,
          linearStep: const [0.0, 0.36, 1.0],
        ),
      );

  Widget _buildChannelInfoView() => Obx(
        () => Positioned(
          left: 12,
          bottom: 14,
          child: ChannelInfoView(
            nameTextWidth: SizeConfig.to.screenWidth - 32 - 12 - 40 - 10,
            imgSize: 40,
            imgUrl: vm.channelImgUrl,
            name: vm.channelName,
            nameFontSize: 16,
            subscriberCount: vm.subscriberCount,
          ),
        ),
      );

  List<Widget> _buildContentDetailInfoView() => [
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
                style: AppTextStyle.body2.copyWith(color: AppColor.lightGrey));
          } else {
            return const SizedBox();
          }
        }),
      ];

  Widget _buildBottomFixedBtn() => LinearBgBottomFloatingBtn(
        text: '등록',
        onTap: vm.requestRegistration,
      );
}
