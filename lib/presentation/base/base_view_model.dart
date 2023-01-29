import 'package:uppercut_fantube/utilities/index.dart';

abstract class BaseViewModel extends GetxController {
  final loading = false.obs;

  void routeBack() {
    print("ARang");
    Get.back();
  }
}
