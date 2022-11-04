import 'package:uppercut_fantube/utilities/index.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsViewModel(), fenix: true);
  }

}