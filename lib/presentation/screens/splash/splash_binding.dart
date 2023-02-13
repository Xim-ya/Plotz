import 'package:get/get.dart';
import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/presentation/screens/splash/splash_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService(Get.find()),fenix: true);
    Get.lazyPut(() => SplashViewModel(Get.find()), fenix: true);

  }
}
