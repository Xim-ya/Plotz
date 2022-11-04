import 'package:uppercut_fantube/ui/screens/tabs/tabs_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsViewModel(), fenix: true);
  }

}