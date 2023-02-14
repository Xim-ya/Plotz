import 'package:soon_sak/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchViewModel(Get.find()), fenix: true);
    Get.lazyPut(() => SearchScaffoldController(), fenix: true);
  }
}
