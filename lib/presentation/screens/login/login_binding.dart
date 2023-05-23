import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();
    print("LOGIN BINDINGsss");
    locator.registerFactory(() => LoginViewModel(
        userService: locator<UserService>(),
        signInHandlerUseCase: locator<SignInAndUpHandlerUseCase>()));

    locator.registerFactory(() => SignInAndUpHandlerUseCase(
        authRepository: locator<AuthRepository>(),
        userService: locator<UserService>()));

    print("LOGIN BINDING!!! DEPENDENCIES");
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<LoginViewModel>();
    locator.unregister<SignInAndUpHandlerUseCase>();
    print("LOGIN BINDING!!! UNREGISTER");
  }
}
