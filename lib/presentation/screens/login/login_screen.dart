import 'dart:io';

import 'package:soon_sak/app/config/gradient_config.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            // Backdrop 이미지
            Image.asset(
              'assets/images/login.png',
              width: SizeConfig.to.screenWidth,
              fit: BoxFit.fitHeight,
            ),
            Positioned.fill(
              child: Container(
                color: AppColor.black.withOpacity(0.4),
              ),
            ),
            Positioned.fill(
              child: Container(
                height: 88,
                decoration: const BoxDecoration(
                  gradient: AppGradient.singleTopToBottom,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.singleBottomToTop,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                height: 300,
                width: SizeConfig.to.screenWidth,
                decoration: const BoxDecoration(
                  gradient: AppGradient.singleBottomToTop,
                ),
              ),
            ),
          ],
        ),
        const Spacer(),
        SvgPicture.asset('assets/icons/login_intro_text.svg'),
        SizedBox(width: SizeConfig.to.screenHeight * 0.0025),
        const Spacer(),
        Padding(
          padding: AppInset.horizontal16 +
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
              AppSpace.size10,
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
      ],
    );
  }

  @override
  LoginViewModel createViewModel(BuildContext context) =>
      locator<LoginViewModel>();
}

// import 'dart:io';
//
// import 'package:soon_sak/utilities/index.dart';
//
// class LoginScreen extends BaseScreen<LoginViewModel> {
//   const LoginScreen({Key? key}) : super(key: key);
//
//   @override
//   bool get wrapWithSafeArea => false;
//
//   @override
//   Widget buildScreen(BuildContext context) {
//     return Stack(
//       children: [
//         // Backdrop 이미지
//         Positioned.fill(
//           top: -120,
//           child: Image.asset(
//             'assets/images/login.png',
//             fit: BoxFit.fitHeight,
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             color: AppColor.black.withOpacity(0.4),
//           ),
//         ),
//         Positioned.fill(
//           child: Container(
//             decoration: const BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.transparent, AppColor.black, AppColor.black],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 stops: <double>[0.0, 0.7, 1.0],
//               ),
//             ),
//           ),
//         ),
//
//         // 서비스 문구
//         Positioned.fill(
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   '순식간에 즐기는\n영화 드라마 리뷰 영상',
//                   textAlign: TextAlign.center,
//                   style: AppTextStyle.headline1,
//                 ),
//                 AppSpace.size20,
//               ],
//             ),
//           ),
//         ),
//
//         Positioned.fill(
//           child: Padding(
//             padding: AppInset.horizontal28 +
//                 EdgeInsets.only(bottom: SizeConfig.to.bottomInset + 24),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 SnsLoginButton(
//                   sns: Sns.google,
//                   onBtnTapped: () {
//                     vm(context).signInAndUp(Sns.google);
//                   },
//                 ),
//                 AppSpace.size20,
//                 if (Platform.isIOS)
//                   SnsLoginButton(
//                     sns: Sns.apple,
//                     onBtnTapped: () {
//                       vm(context).signInAndUp(Sns.apple);
//                     },
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   @override
//   LoginViewModel createViewModel(BuildContext context) =>
//       locator<LoginViewModel>();
// }
