import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';

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
