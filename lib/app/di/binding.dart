abstract class Bindings {
  late dynamic arg1;
  late dynamic arg2;

  bool isDependenciesDeleted = true;

  void dependencies() {
    isDependenciesDeleted = false;
  }

  void unRegisterDependencies() {
    isDependenciesDeleted = true;
  }
}
