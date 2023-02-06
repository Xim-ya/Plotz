import 'package:get/get.dart';
import 'package:uppercut_fantube/presentation/screens/login/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginViewModel());
  }
}
