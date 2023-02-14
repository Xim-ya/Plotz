import 'package:get/get.dart';
import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/presentation/screens/splash/splash_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => UserService(Get.find()),fenix: true);
    Get.lazyPut(() => SplashViewModel(Get.find()), fenix: true);

  }
}
