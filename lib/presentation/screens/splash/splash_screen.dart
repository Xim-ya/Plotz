import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashScreen extends BaseScreen<SplashViewModel> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  bool get wrapWithSafeArea => false;

  @override
  Widget buildScreen(BuildContext context) {
    vm(context).checkVersionAndNetwork(context);
    return Container(
      color: AppColor.black,
      child: Center(
          child: SvgPicture.asset(
        'assets/icons/new_logo.svg',
        width: 190,
      )),
    );
  }

  @override
  SplashViewModel createViewModel(BuildContext context) =>
      locator<SplashViewModel>();
}
