import 'package:get/get.dart';
import 'package:uppercut_fantube/app/modules/data_modules.dart';
import 'package:uppercut_fantube/app/modules/domain_modules.dart';
import 'package:uppercut_fantube/app/modules/presentation_modules.dart';



class AppBinding extends Bindings {
  @override
  void dependencies() {
    PresentationModules.dependencies();
    DomainModules.dependencies();
    DataModules.getDependencies();
  }
}