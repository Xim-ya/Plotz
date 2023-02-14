import 'package:soon_sak/presentation/screens/quration/register/register_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

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
