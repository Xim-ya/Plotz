import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_newly_added_contents.u.dart';
import 'package:soon_sak/presentation/index.dart';

abstract class TabsBinding {
  TabsBinding._();

  static void dependencies() {
    locator.registerLazySingleton(
      () => HomeViewModel(
        loadNewlyAddedContentUseCase: locator<LoadCachedNewlyAddedContentsUseCase>(),
        loadPagedCategoryCollectionsUseCase:
            locator<LoadPagedCategoryCollectionUseCase>(),
        loadCachedTopPositionedContentsUseCase:
            locator<LoadCachedTopPositionedContentsUseCase>(),
        loadCachedTopTenContentsUseCase:
            locator<LoadCachedTopTenContentsUseCase>(),
        loadBannerContentUseCase: locator<LoadCachedBannerContentUseCase>(),
        channelRepository: locator<ChannelRepository>(),
      ),
    );

    locator.registerLazySingleton(() => ExploreViewModel(
        exploreContentsUseCase:
            locator<LoadRandomPagedExploreContentsUseCase>()));

    locator.registerLazySingleton(
      () => SearchViewModel(
          searchHandler: locator<SearchedPagedContentUseCase>(),
          contentRepository: locator<ContentRepository>(),
          userService: locator<UserService>()),
    );

    locator.registerLazySingleton(() =>
        SearchScaffoldController(searchViewModel: locator<SearchViewModel>()));

    locator.registerLazySingleton(() =>
        SearchedPagedContentUseCase(tmdbRepository: locator<TmdbRepository>()));

    locator.registerLazySingleton(
      () => MyPageViewModel(
        userRepository: locator<UserRepository>(),
        userService: locator<UserService>(),
        signOutHandlerUseCase: locator<SignOutUseCase>(),
      ),
    );

    locator.registerFactory(
      () => TabsViewModel(
        exploreViewModel: locator<ExploreViewModel>(),
        myPageViewModel: locator<MyPageViewModel>(),
        searchViewModel: locator<SearchViewModel>(),
      ),
    );
  }

  static void unRegisterDependencies() {
    locator.unregister<TabsViewModel>();
    locator.unregister<HomeViewModel>();
    locator.unregister<SearchViewModel>();
    locator.unregister<ExploreViewModel>();
    locator.unregister<SearchScaffoldController>();
    locator.unregister<SearchedPagedContentUseCase>();
    locator.unregister<MyPageViewModel>();
  }
}
