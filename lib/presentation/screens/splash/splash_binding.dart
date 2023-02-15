import 'package:soon_sak/utilities/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService(Get.find()),fenix: true);
    Get.lazyPut(() => SplashViewModel(Get.find()), fenix: true);

  }
}
