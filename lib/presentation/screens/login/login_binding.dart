import 'package:soon_sak/utilities/index.dart';

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
