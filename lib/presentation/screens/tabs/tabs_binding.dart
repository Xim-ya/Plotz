import 'package:soon_sak/utilities/index.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsViewModel(), fenix: true);
  }

}