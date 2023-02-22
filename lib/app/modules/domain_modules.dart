import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static Future<void> dependencies() async {




    // 인증
    Get.lazyPut(() => SignOutUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SignInAndUpHandlerUseCase(Get.find(), Get.find()),
        fenix: true);

    // 컨텐츠
    Get.lazyPut(
        () =>
            LoadCachedBannerContentUseCase(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () =>
            LoadCachedTopTenContentsUseCase(Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
        () => LoadCachedCategoryContentCollectionUseCase(
            Get.find(), Get.find(), Get.find()),
        fenix: true);
    Get.lazyPut(
      () =>
          RequestContentRegistrationUseCase(Get.find(), Get.find(), Get.find()),
      fenix: true,
    );

    // TMDB
    Get.lazyPut(() => LoadContentDetailInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentCreditInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentImgListUseCase(Get.find()), fenix: true);

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
