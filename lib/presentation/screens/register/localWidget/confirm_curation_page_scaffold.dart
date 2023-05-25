import 'package:soon_sak/utilities/index.dart';

class ConfirmCurationPageScaffold extends StatelessWidget {
  const ConfirmCurationPageScaffold(
      {Key? key,
      required this.leadingText,
      required this.responsiveHInset,
      required this.posterImg,
      required this.channelInfoView,
      required this.contentDetailInfoView,
      required this.bottomFixedBtn,})
      : super(key: key);

  final String leadingText;
  final double responsiveHInset;
  final Widget posterImg;
  final Widget channelInfoView;
  final Widget contentDetailInfoView;
  final Widget bottomFixedBtn;

  @override
  Widget build(BuildContext context) {
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
                    leadingText,
                    style: AppTextStyle.headline1,
                  ),
                ),
                AppSpace.size8,

                // 등록 컨텐츠 정보
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: responsiveHInset),
                  child: Stack(
                    children: <Widget>[
                      // 컨텐츠 포스터 이미지
                      posterImg,

                      // 채널 정보
                      channelInfoView,
                    ],
                  ),
                ),
                AppSpace.size10,

                // 컨텐츠 상세 정보
                SizedBox(
                  width: double.infinity,
                  child: contentDetailInfoView,
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
                    bottom: SizeConfig.to.responsiveBottomInset,),
                child: bottomFixedBtn,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
