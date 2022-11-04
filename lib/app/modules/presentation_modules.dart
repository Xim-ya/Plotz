import 'package:uppercut_fantube/ui/screens/tabs/tabs_screen.dart';
import 'package:uppercut_fantube/ui/screens/tabs/tabs_view_model.dart';

import '../../utilities/index.dart';

abstract class PresentationModules {
  PresentationModules._();

  static void dependencies() {
    // 탭 스크린
    Get.lazyPut(() => TabsViewModel(), fenix: true);

  }
}