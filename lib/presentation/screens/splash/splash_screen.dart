import 'package:soon_sak/utilities/index.dart';

class SplashScreen extends BaseScreen<SplashViewModel> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    return Container(
      color: AppColor.black,
      child: Center(
        child: SvgPicture.asset('assets/icons/main_logo.svg',
        width: 190,
        ),
      ),
    );
  }
}
