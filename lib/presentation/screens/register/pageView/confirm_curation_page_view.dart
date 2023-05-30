import 'package:provider/provider.dart';
import 'package:soon_sak/presentation/base/base_view.dart';
import 'package:soon_sak/presentation/screens/register/localWidget/confirm_curation_page_scaffold.dart';
import 'package:soon_sak/utilities/index.dart';

class ConfirmCurationPageView extends BaseView<RegisterViewModel> {
  const ConfirmCurationPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConfirmCurationPageScaffold(
      leadingText: '입력된 컨텐츠\n정보가 맞는지 확인해주세요!',
      responsiveHInset: vm(context).responsiveHInset,
      posterImg: const _PosterImg(),
      channelInfoView: const _ChannelInfoView(),
      contentDetailInfoView: const _DetailInfoView(),
      bottomFixedBtn: _buildBottomFixedBtn(context),
    );
  }

  Widget _buildBottomFixedBtn(BuildContext context) =>
      LinearBgBottomFloatingBtn(
        text: '등록',
        onTap: vm(context).requestRegistration,
      );
}

class _DetailInfoView extends BaseView<RegisterViewModel> {
  const _DetailInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewModel, Content?>(
      selector: (context, vm) => vm.curationContent,
      builder: (context, _, __) {
        return Column(children: <Widget>[
          Text(
            vm(context).contentTitle ?? '',
            style: AppTextStyle.title1,
            textAlign: TextAlign.center,
          ),
          AppSpace.size2,
          if (vm(context).releaseDate.hasData)
            Text(
              Formatter.dateToyyyyMMdd(vm(context).releaseDate!),
              style: AppTextStyle.body2.copyWith(color: AppColor.lightGrey),
            )
        ]);
      },
    );
  }
}

class _ChannelInfoView extends BaseView<RegisterViewModel> {
  const _ChannelInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewModel, Content?>(
      selector: (context, vm) => vm.curationContent,
      builder: (context, _, __) {
        return Positioned(
          left: 12,
          bottom: 14,
          child: ChannelInfoView(
            nameTextWidth: SizeConfig.to.screenWidth - 32 - 12 - 40 - 10,
            imgSize: 40,
            imgUrl: vm(context).channelImgUrl,
            name: vm(context).channelName,
            nameFontSize: 16,
            subscriberCount: vm(context).subscriberCount,
          ),
        );
      },
    );
  }
}

class _PosterImg extends BaseView<RegisterViewModel> {
  const _PosterImg({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<RegisterViewModel, String?>(
      selector: (context, vm) => vm.posterImgUrl,
      builder: (context, imgUrl, _) => LinearLayeredPosterImg(
        aspectRatio: 273 / 412,
        imgUrl: imgUrl,
        linearColor: Colors.black,
        linearStep: const [0.0, 0.36, 1.0],
      ),
    );
  }
}
