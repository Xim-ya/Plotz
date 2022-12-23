import 'package:uppercut_fantube/presentation/screens/search/localWidget/search_scaffold_controller.dart';
import 'package:uppercut_fantube/presentation/screens/search/search_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchViewModel(Get.find()), fenix: true);
    Get.lazyPut(() => SearchScaffoldController(), fenix: true);
  }
}
