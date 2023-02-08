import 'package:get/get.dart';
import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/presentation/screens/login/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewModel(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(() => UserService(), fenix: true);
  }
}
