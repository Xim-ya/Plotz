import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/utilities/index.dart';

class CurationHistoryBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(() => CurationHistoryViewModel(
        userRepository: locator<UserRepository>(),
        userService: locator<UserService>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<CurationHistoryViewModel>();
  }
}
