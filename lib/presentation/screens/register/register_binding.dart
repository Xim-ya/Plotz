import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => RegisterViewModel(
        contentType: Get.arguments,
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      fenix: false,
    );

    Get.lazyPut(
      () =>
          RequestContentRegistrationUseCase(Get.find(), Get.find(), Get.find()),
      fenix: false,
    );

    // Register
    Get.put<SearchValidateUrlUseCase>(SearchValidateUrlImpl());
  }
}
