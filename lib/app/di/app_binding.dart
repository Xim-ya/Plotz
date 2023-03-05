import 'package:soon_sak/utilities/index.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {

    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();
  }
}
