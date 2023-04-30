import 'package:soon_sak/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SearchViewModel(Get.find(), Get.find(), Get.find()));
    Get.put(SearchScaffoldController(Get.find()));


  }
}
