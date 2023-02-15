import 'package:soon_sak/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  // 우선적으로 inject 되어야하는 모듈
  static Future<void> _preLoadDependencies() async {
    // Service
    Get.put(ContentService(Get.find()));
    Get.put(LocalStorageService());
  }

  static void dependencies() {
    _preLoadDependencies();

    // 인증
    Get.lazyPut(() => SignOutUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SignInAndUpHandlerUseCase(Get.find(), Get.find()),
        fenix: true);

    // 컨텐츠
    Get.lazyPut(() => PartialLoadContentUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadCachedBannerContentUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadCachedTopTenContentsUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadCachedCategoryContentCollectionUseCase(Get.find()),
        fenix: true);

    // TMDB
    Get.lazyPut(() => LoadContentDetailInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentCreditInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentImgListUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadExploreContentBySlierIndexUseCase(Get.find()),
        fenix: true);

    // Video
    Get.lazyPut(() => LoadContentOfVideoListUseCase(Get.find()), fenix: true);

    // Explore
    Get.lazyPut(
        () => LoadRandomPagedExploreContentsUseCase(Get.find(), Get.find()),
        fenix: true);

    // Register
    Get.lazyPut<SearchValidateUrlUseCase>(() => SearchValidateUrlImpl(),
        fenix: true);

    // Search
    Get.lazyPut<SearchPagedContentUseCase>(
        () => SearchPagedContentImpl(Get.find()),
        fenix: true);
  }
}
