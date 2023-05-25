import 'package:get_it/get_it.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/app/di/modules/data_modules.dart';
import 'package:soon_sak/app/di/modules/domain_modules.dart';
import 'package:soon_sak/app/di/modules/presentation_modules.dart';
import 'package:soon_sak/data/repository/auth/auth_repository.dart';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/domain/service/content_service.dart';
import 'package:soon_sak/domain/service/local_storage_service.dart';
import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/presentation/screens/splash/splash_view_model.dart';

abstract class NewAppBinding {
  NewAppBinding._();

  static void _initialBinding() {
    GetIt.I.registerFactory<SplashViewModel>(
          () =>
          SplashViewModel(
            userService: GetIt.I<UserService>(),
            contentService: GetIt.I<ContentService>(),
            localStorageService: GetIt.I<LocalStorageService>(),
            checkVersionAndNetworkUseCase: GetIt.I<
                CheckVersionAndNetworkUseCase>(),
          ),
    );

  }

  static void dependencies() {
    _initialBinding();
    NewPresentationModules.dependencies();
    NewDomainModules.dependencies();
    NewDataModules.dependencies();
  }
}
