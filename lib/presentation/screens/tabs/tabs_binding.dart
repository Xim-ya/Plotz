import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';

abstract class TabsBinding {
  TabsBinding._();

  static void dependencies() {
    locator.registerLazySingleton(
      () => HomeViewModel(
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
      ),
    );
  }

  static void unRegisterDependencies() {
    locator.unregister<TabsViewModel>();
    locator.unregister<HomeViewModel>();
    locator.unregister<ExploreViewModel>();
    locator.unregister<MyPageViewModel>();
  }
}
