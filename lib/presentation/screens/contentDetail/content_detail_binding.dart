import 'package:uppercut_fantube/utilities/index.dart';


class ContentDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContentDetailViewModel(Get.find()), fenix: true);
  }
}