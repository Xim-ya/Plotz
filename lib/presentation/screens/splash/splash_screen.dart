import 'package:uppercut_fantube/presentation/screens/splash/splash_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SplashScreen extends BaseScreen<SplashViewModel> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      color: AppColor.black,
      child: Center(
        child: Text(
          'Splash',
          style: AppTextStyle.web3,
        ),
      ),
    );
  }
}
