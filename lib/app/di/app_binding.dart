import 'package:soon_sak/utilities/index.dart';

class AppBinding extends Bindings {
  @override
  Future<void> dependencies() async{
    DataModules.getDependencies();
    DomainModules.dependencies();
    PresentationModules.dependencies();
  }
}
