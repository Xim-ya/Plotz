import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_top_positioned_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

// class TabsBinding extends CustomBindings {
//   @override
//   void dependencies() {
//     super.dependencies();
//     locator.registerLazySingleton(
//       () => HomeViewModel(
//         loadPagedCategoryCollectionsUseCase:
//             locator<LoadPagedCategoryCollectionUseCase>(),
//         loadCachedTopPositionedContentsUseCase:
//             locator<LoadCachedTopPositionedContentsUseCase>(),
//         loadCachedTopTenContentsUseCase:
//             locator<LoadCachedTopTenContentsUseCase>(),
//         loadBannerContentUseCase: locator<LoadCachedBannerContentUseCase>(),
//         channelRepository: locator<ChannelRepository>(),
//       ),
//     );
//
//     locator.registerLazySingleton(() => ExploreViewModel(
//         exploreContentsUseCase:
//             locator<LoadRandomPagedExploreContentsUseCase>()));
//
//     locator.registerLazySingleton(() =>
//         CurationViewModel(contentRepository: locator<ContentRepository>()));
//     // locator.registerFactory(() =>
//     //     CurationViewModel(contentRepository: locator<ContentRepository>()));
//
//     locator.registerLazySingleton(
//       () => MyPageViewModel(
//         userRepository: locator<UserRepository>(),
//         userService: locator<UserService>(),
//       ),
//     );
//
//     locator.registerFactory(
//       () => TabsViewModel(
//         exploreViewModel: locator<ExploreViewModel>(),
//         curationViewModel: locator<CurationViewModel>(),
//         myPageViewModel: locator<MyPageViewModel>(),
//       ),
//     );
//   }
//
//   void intentUnregister() {
//     isDependenciesDeleted = true;
//     locator.unregister<TabsViewModel>();
//     locator.unregister<HomeViewModel>();
//     locator.unregister<ExploreViewModel>();
//     locator.unregister<CurationViewModel>();
//     locator.unregister<MyPageViewModel>();
//   }
// }


abstract class TabsBinding  {
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

    locator.registerLazySingleton(() =>
        CurationViewModel(contentRepository: locator<ContentRepository>()));
    // locator.registerFactory(() =>
    //     CurationViewModel(contentRepository: locator<ContentRepository>()));

    locator.registerLazySingleton(
          () => MyPageViewModel(
        userRepository: locator<UserRepository>(),
        userService: locator<UserService>(),
      ),
    );

    locator.registerFactory(
          () => TabsViewModel(
        exploreViewModel: locator<ExploreViewModel>(),
        curationViewModel: locator<CurationViewModel>(),
        myPageViewModel: locator<MyPageViewModel>(),
      ),
    );
  }

  static void unRegisterDependencies() {
    locator.unregister<TabsViewModel>();
    locator.unregister<HomeViewModel>();
    locator.unregister<ExploreViewModel>();
    locator.unregister<CurationViewModel>();
    locator.unregister<MyPageViewModel>();
  }
}
