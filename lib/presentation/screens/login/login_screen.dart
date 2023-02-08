import 'package:uppercut_fantube/domain/enum/sns_type_enum.dart';
import 'package:uppercut_fantube/presentation/screens/login/localWidget/sns_login_button.dart';
import 'package:uppercut_fantube/presentation/screens/login/login_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class LoginScreen extends BaseScreen<LoginViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Stack(
      children: [
        // Backdrop 이미지
        Positioned.fill(
          top: -120,
          child: Image.asset(
            'assets/images/login_back_drop.png',
            fit: BoxFit.fitHeight,
          ),
        ),
        Positioned.fill(
          child: Container(
            color: AppColor.black.withOpacity(0.4),
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.transparent, AppColor.black, AppColor.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: <double>[0.0, 0.7, 1.0],
              ),
            ),
          ),
        ),

        // 서비스 문구
        Positioned.fill(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  '모두가 엄선한\n영화 드라마 리뷰 컨텐츠가 한 곳에',
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
                  onBtnTapped:(){
                    vm.googleSignIn();
                  },
                ),
                AppSpace.size20,
                SnsLoginButton(
                  sns: Sns.apple,
                  onBtnTapped: () {
                    vm.checkUserState();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
