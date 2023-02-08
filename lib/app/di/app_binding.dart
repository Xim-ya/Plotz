import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {


    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();
  }
}
