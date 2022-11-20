import 'package:get/get.dart';
import 'package:uppercut_fantube/app/modules/data_modules.dart';
import 'package:uppercut_fantube/app/modules/domain_modules.dart';
import 'package:uppercut_fantube/app/modules/presentation_modules.dart';



class AppBinding extends Bindings {
  @override
  void dependencies() {
    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();


  }
}