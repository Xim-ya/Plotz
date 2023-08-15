import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_newly_added_contents.u.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    /* Service */
    locator.registerLazySingleton(() => UserService(
        authRepository: locator<AuthRepository>(),
        userRepository: locator<UserRepository>()));

    locator.registerLazySingleton(() => LocalStorageService());

    locator.registerLazySingleton(() => ContentService(
        contentRepository: locator<ContentRepository>(),
        staticContentRepository: locator<StaticContentRepository>()));

    /* UseCase */
    locator.registerLazySingleton(() => CheckVersionAndNetworkUseCase(
        repository: locator<VersionRepository>(),
        userService: locator<UserService>()));

    locator.registerLazySingleton(() => LoadRandomPagedExploreContentsUseCase(
        repository: locator<ContentRepository>(),
        service: locator<ContentService>()));

    locator.registerLazySingleton(() => LoadCachedTopPositionedContentsUseCase(
        repository: locator<StaticContentRepository>(),
        localStorageService: locator<LocalStorageService>(),
        contentService: locator<ContentService>()));

    locator.registerLazySingleton(() => LoadCachedNewlyAddedContentsUseCase(
        repository: locator<StaticContentRepository>(),
        localStorageService: locator<LocalStorageService>(),
        contentService: locator<ContentService>()));

    locator.registerLazySingleton(() => LoadPagedCategoryCollectionUseCase(
          staticContentRepository: locator<StaticContentRepository>(),
          localStorageService: locator<LocalStorageService>(),
          contentService: locator<ContentService>(),
        ));

    locator.registerLazySingleton(() => LoadCachedTopTenContentsUseCase(
          repository: locator<StaticContentRepository>(),
          localStorageService: locator<LocalStorageService>(),
          contentService: locator<ContentService>(),
        ));

    locator.registerLazySingleton(() => LoadCachedBannerContentUseCase(
        repository: locator<StaticContentRepository>(),
        localStorageService: locator<LocalStorageService>(),
        contentService: locator<ContentService>()));

    locator
        .registerLazySingleton(() => SignOutUseCase(locator<AuthRepository>()));
  }
}
