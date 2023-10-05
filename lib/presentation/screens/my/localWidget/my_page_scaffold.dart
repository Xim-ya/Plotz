import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/screens/my/my_page_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageScaffold extends StatelessWidget {
  const MyPageScaffold(
      {Key? key,
      required this.scrollController,
      required this.profileInfoView,
      required this.watchHistorySlider,
      required this.currentVersionInfoTile,
      required this.settingBtnList,
      required this.hideTopLinearGradient,
      required this.requestedContentIndicator})
      : super(key: key);

  final ScrollController scrollController;
  final Widget profileInfoView;
  final Widget watchHistorySlider;
  final Widget currentVersionInfoTile;
  final Widget requestedContentIndicator;
  final List<Widget> settingBtnList;
  final bool hideTopLinearGradient;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(height: 60),
              // 상단 프로필 이미지
              profileInfoView,
              AppSpace.size36,
              // 시청 기록
              Padding(
                padding: AppInset.left16,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '시청 기록',
                    style: AppTextStyle.title2,
                  ),
                ),
              ),
              AppSpace.size8,
              watchHistorySlider,
              AppSpace.size56,

              requestedContentIndicator,

              AppSpace.size16,
              // 환경설정
              Padding(
                padding: AppInset.left16,
                child: Text(
                  '환경 설정',
                  style: AppTextStyle.title2,
                ),
              ),
              currentVersionInfoTile,
              ...settingBtnList,
              AppSpace.size56,
            ],
          ),
        ),
        Positioned(
          top: 0,
          child: Selector<MyPageViewModel, bool>(
            selector: (_, vm) => hideTopLinearGradient,
            builder: (_, hideGradient, __) => AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: hideGradient ? 0 : 1,
              child: Container(
                height: 88,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.topToBottom,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
