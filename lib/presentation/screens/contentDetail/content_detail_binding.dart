import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
        () => ContentDetailViewModel(
            argument: Get.arguments,
            Get.find(),
            Get.find(),
            Get.find(),
            Get.find()),
        fenix: true);
  }
}
