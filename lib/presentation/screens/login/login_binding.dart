import 'package:soon_sak/utilities/index.dart';

abstract class LoginBinding {
  static void dependencies() {
    safeRegisterFactory<LoginViewModel>(
      () => LoginViewModel(
        userService: locator<UserService>(),
        signInHandlerUseCase: locator<SignInAndUpHandlerUseCase>(),
      ),
    );

    safeRegisterFactory<SignInAndUpHandlerUseCase>(() =>
        SignInAndUpHandlerUseCase(
            authRepository: locator<AuthRepository>(),
            userService: locator<UserService>()));
  }

  static void unRegisterDependencies() {
    safeUnregister<LoginViewModel>();
    safeUnregister<SignInAndUpHandlerUseCase>();
  }
}
