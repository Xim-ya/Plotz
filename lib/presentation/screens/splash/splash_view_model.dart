import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SplashViewModel extends BaseViewModel {

  // 라우팅 핸들러
  Future<void> handleRoute() async {
    if (UserService.to.isUserSignIn) {
      await Get.offAllNamed(AppRoutes.tabs);
    } else {
      await Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  void onReady() {
    super.onReady();

    handleRoute();
  }
}
