import 'package:get/get.dart';
import 'package:uppercut_fantube/presentation/screens/splash/splash_view_model.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SplashViewModel(), fenix: true);
  }
}
