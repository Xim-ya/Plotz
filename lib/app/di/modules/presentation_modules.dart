import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_top_positioned_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class NewPresentationModules {
  static void dependencies() {
    // locator.registerLazySingleton(
    //       () => TabsViewModel(
    //     exploreViewModel: locator<ExploreViewModel>(),
    //     curationViewModel: locator<CurationViewModel>(),
    //     myPageViewModel: locator<MyPageViewModel>(),
    //   ),
    // );
    //
    //
    // locator.registerLazySingleton(
    //   () => HomeViewModel(
    //     loadPagedCategoryCollectionsUseCase:
    //         locator<LoadPagedCategoryCollectionUseCase>(),
    //     loadCachedTopPositionedContentsUseCase:
    //         locator<LoadCachedTopPositionedContentsUseCase>(),
    //     loadCachedTopTenContentsUseCase:
    //         locator<LoadCachedTopTenContentsUseCase>(),
    //     loadBannerContentUseCase: locator<LoadCachedBannerContentUseCase>(),
    //     channelRepository: locator<ChannelRepository>(),
    //   ),
    // );
    //
    //
    // locator.registerLazySingleton(() => ExploreViewModel(
    //     exploreContentsUseCase:
    //         locator<LoadRandomPagedExploreContentsUseCase>()));
    //
    // locator.registerLazySingleton(() =>
    //     CurationViewModel(contentRepository: locator<ContentRepository>()));
    //
    // locator.registerLazySingleton(
    //   () => MyPageViewModel(
    //     userRepository: locator<UserRepository>(),
    //     userService: locator<UserService>(),
    //   ),
    // );
  }
}
