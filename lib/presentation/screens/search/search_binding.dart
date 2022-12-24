import 'package:uppercut_fantube/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchViewModel(Get.find()), fenix: true);
    Get.lazyPut(() => SearchScaffoldController(), fenix: true);
  }
}
