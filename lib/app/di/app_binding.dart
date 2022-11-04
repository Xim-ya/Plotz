import 'package:get/get.dart';
import 'package:uppercut_fantube/app/modules/presentation_modules.dart';
import 'package:uppercut_fantube/ui/screens/tabs/tabs_screen.dart';


class AppBinding extends Bindings {
  @override
  void dependencies() {

    PresentationModules.dependencies();

  }
}