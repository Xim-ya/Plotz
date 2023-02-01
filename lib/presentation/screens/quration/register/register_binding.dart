import 'package:uppercut_fantube/presentation/screens/quration/register/register_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterViewModel(
        contentType: Get.arguments,
        Get.find(),
        Get.find(),
      ),
    );
  }
}
