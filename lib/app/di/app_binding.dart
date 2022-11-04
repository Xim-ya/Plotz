import 'package:get/get.dart';
import 'package:uppercut_fantube/app/modules/presentation_modules.dart';



class AppBinding extends Bindings {
  @override
  void dependencies() {

    PresentationModules.dependencies();

  }
}