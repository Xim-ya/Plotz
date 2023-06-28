import 'dart:io';
import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        const SizedBox.expand(),
        Stack(
          children: [
            // Backdrop 이미지
            Image.asset(
              'assets/images/login.png',
              width: SizeConfig.to.screenWidth,
              fit: BoxFit.fitHeight,
            ),
            Positioned(
              child: Container(
                width: SizeConfig.to.screenWidth,
                height: 88,
                decoration: const BoxDecoration(
                  gradient: AppGradient.topToBottom,
                ),
              ),
            ),
            Positioned(
              bottom: -2,
              child: Container(
                height: 300,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.bottomToTop,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.bottomToTop,
                ),
              ),
            ),
          ],
        ),

        /// 정확한 디자인 규칙이 정해져 있지 않아 고정값을 비율설정하여 적용
        /// 플랫폼에 따라 보여지는 레이아웃과 버튼의 종류가 다름 (Andorid의 경우 애플 로그인 버튼을 노출 X)
        if (Platform.isIOS)
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child:
                        SvgPicture.asset('assets/icons/login_intro_text.svg')),
                SizedBox(
                  height: SizeConfig.to.screenHeight * 0.062,
                ),
                Padding(
                  padding: AppInset.horizontal16 +
                      EdgeInsets.only(
                        bottom: SizeConfig.to.bottomInset == 0
                            ? SizeConfig.to.screenHeight * 0.056
                            : SizeConfig.to.screenHeight * 0.014,
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SnsLoginButton(
                        sns: Sns.google,
                        onBtnTapped: () {
                          vm(context).signInAndUp(Sns.google);
                        },
                      ),
                      AppSpace.size10,
                      SnsLoginButton(
                        sns: Sns.apple,
                        onBtnTapped: () {
                          vm(context).signInAndUp(Sns.apple);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        else
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Center(
                    child:
                        SvgPicture.asset('assets/icons/login_intro_text.svg')),
                SizedBox(
                  height: SizeConfig.to.screenHeight * 0.099,
                ),
                Padding(
                  padding: AppInset.horizontal16 +
                      EdgeInsets.only(
                        bottom: SizeConfig.to.bottomInset == 0
                            ? SizeConfig.to.screenHeight * 0.05
                            : SizeConfig.to.screenHeight * 0.008,
                      ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SnsLoginButton(
                        sns: Sns.google,
                        onBtnTapped: () {
                          vm(context).signInAndUp(Sns.google);
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
      ],
    );
  }

  @override
  bool get wrapWithSafeArea => true;

  @override
  bool get setTopSafeArea => false;

  @override
  LoginViewModel createViewModel(BuildContext context) =>
      locator<LoginViewModel>();
}
