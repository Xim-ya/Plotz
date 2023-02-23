import 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchViewModel(Get.find()), fenix: true);
    Get.lazyPut(() => SearchScaffoldController(Get.find()), fenix: true);
  }
}
