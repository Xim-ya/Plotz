import 'package:soon_sak/utilities/index.dart';

abstract class LoginBinding {
  static void dependencies() {
    locator.registerFactory(() => LoginViewModel(
        userService: locator<UserService>(),
        signInHandlerUseCase: locator<SignInAndUpHandlerUseCase>()));

    locator.registerFactory(() => SignInAndUpHandlerUseCase(
        authRepository: locator<AuthRepository>(),
        userService: locator<UserService>()));
  }

  static void unRegisterDependencies() {
    locator.unregister<LoginViewModel>();
    locator.unregister<SignInAndUpHandlerUseCase>();
  }
}
