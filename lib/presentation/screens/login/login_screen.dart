import 'dart:io';

import 'package:soon_sak/utilities/index.dart';

class LoginScreen extends NewBaseScreen<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        // Backdrop 이미지
        Positioned.fill(
          top: -140,
          child: Transform.translate(
            offset: Offset(0, -240),
            child: SizedBox(
              width: 709.25,
              height: 1008,
              child: Image.asset(
                'assets/images/login_back_drop1.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColor.black.withOpacity(0.4),
          ),
        ),
        // Positioned.fill(
        //   child: Container(
        //     decoration: const BoxDecoration(
        //       gradient: LinearGradient(
        //         colors: [Colors.transparent, AppColor.black, AppColor.black],
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         stops: <double>[0.0, 0.7, 1.0],
        //       ),
        //     ),
        //   ),
        // ),

        // 서비스 문구
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '순식간에 즐기는\n영화 드라마 리뷰 영상',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.headline1,
                ),
                AppSpace.size20,
              ],
            ),
          ),
        ),

        Positioned.fill(
          child: Padding(
            padding: AppInset.horizontal28 +
                EdgeInsets.only(bottom: SizeConfig.to.bottomInset + 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SnsLoginButton(
                  sns: Sns.google,
                  onBtnTapped: () {
                    vm(context).signInAndUp(Sns.google);
                  },
                ),
                AppSpace.size20,
                if (Platform.isIOS)
                  SnsLoginButton(
                    sns: Sns.apple,
                    onBtnTapped: () {
                      vm(context).signInAndUp(Sns.apple);
                    },
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  LoginViewModel createViewModel(BuildContext context) =>
      locator<LoginViewModel>();
}
