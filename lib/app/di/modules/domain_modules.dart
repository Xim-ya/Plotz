import 'package:soon_sak/domain/useCase/content/home/load_cached_top_positioned_content_use_case.dart';
import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class NewDomainModules {
  NewDomainModules._();

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

    // /* Search */
    // locator.registerLazySingleton(() => NewSearchedPagedContentUseCase(
    //     tmdbRepository: locator<TmdbRepository>()));
  }
}
