import 'package:get/get.dart';
import 'package:soon_sak/presentation/screens/login/login_view_model.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => LoginViewModel(
        Get.find(),
        Get.find(),
      ),
      fenix: true,
    );
  }
}
