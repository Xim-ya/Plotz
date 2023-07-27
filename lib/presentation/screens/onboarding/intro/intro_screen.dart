import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.black,
      body: Stack(
        children: [
          Column(
            children: <Widget>[
              // 이미지
              Stack(
                children: [
                  Image.asset(
                    'assets/images/intro.png',
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: SizeConfig.to.screenWidth,
                      height: SizeConfig.to.screenHeight * 0.369,
                      decoration: const BoxDecoration(
                        gradient: AppGradient.bottomToTop,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            bottom: SizeConfig.to.screenHeight * 0.11 +
                SizeConfig.to.screenHeight * 0.192,
            right: 0,
            left: 0,
            child: Column(
              children: [
                // 인트로 문구
                Text(
                  '플로츠를 시작할 준비 완료',
                  style: AppTextStyle.title3.copyWith(color: AppColor.main),
                ),
                AppSpace.size4,
                Text(
                  '다양한 리뷰 콘텐츠를\n즐겨보세요!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headline1.copyWith(
                    color: AppColor.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: MaterialButton(
              onPressed: () {
                context.go(AppRoutes.tabs);
                TabsBinding.dependencies();
              },
              color: AppColor.gray06,
              padding: EdgeInsets.only(bottom: SizeConfig.to.bottomInset),
              minWidth: SizeConfig.to.screenWidth,
              height: 48 + SizeConfig.to.bottomInset,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '시작하기',
                  style: AppTextStyle.headline3.copyWith(color: AppColor.main),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
