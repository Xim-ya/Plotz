import 'package:soon_sak/presentation/screens/newSearch/localWidget/new_search_scaffold_controller.dart';
import 'package:soon_sak/presentation/screens/newSearch/new_search_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class NewSearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NewSearchViewModel(Get.find()), fenix: true);
    Get.lazyPut(() => NewSearchScaffoldController(Get.find()), fenix: true);
  }
}
