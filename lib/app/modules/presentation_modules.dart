import 'package:uppercut_fantube/presentation/screens/home/home_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class PresentationModules {
  PresentationModules._();

  static void dependencies() {
    // 탭 스크린
    Get.lazyPut(() => TabsViewModel(), fenix: true);
    Get.lazyPut(() => HomeViewModel(), fenix: true);

  }
}