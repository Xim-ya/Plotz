import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/presentation/screens/setting/setting_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(() => SignOutUseCase(locator<AuthRepository>()));
    locator.registerFactory(
      () => SettingViewModel(
        signOutHandlerUseCase: locator<SignOutUseCase>(),
        userService: locator<UserService>(),
        userRepository: locator<UserRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<SignOutUseCase>();
    locator.unregister<SettingViewModel>();
  }
}
