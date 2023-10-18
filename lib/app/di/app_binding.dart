import 'package:get_it/get_it.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/app/di/modules/data_modules.dart';
import 'package:soon_sak/app/di/modules/domain_modules.dart';
import 'package:soon_sak/domain/service/content_service.dart';
import 'package:soon_sak/domain/service/local_storage_service.dart';
import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/presentation/screens/splash/splash_view_model.dart';

abstract class AppBinding {
  AppBinding._();

  static void _initialBinding() {
    locator.registerFactory<SplashViewModel>(
      () => SplashViewModel(
        userService: GetIt.I<UserService>(),
        contentService: GetIt.I<ContentService>(),
        localStorageService: GetIt.I<LocalStorageService>(),
        checkVersionAndNetworkUseCase: GetIt.I<CheckVersionAndNetworkUseCase>(),
      ),
    );
  }

  static void dependencies() {
    _initialBinding();
    DomainModules.dependencies();
    DataModules.dependencies();
  }
}
