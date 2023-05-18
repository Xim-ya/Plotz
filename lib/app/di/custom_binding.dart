import 'package:soon_sak/utilities/index.dart';

abstract class CustomBindings {
  late dynamic argument;

  bool isDependenciesDeleted = true;

  void dependencies() {
    isDependenciesDeleted = false;
  }

  void unRegisterDependencies() {
    isDependenciesDeleted = true;
  }
}
