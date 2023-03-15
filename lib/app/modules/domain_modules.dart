import 'package:soon_sak/domain/useCase/content/home/load_paged_category_collection_use_case.dart';
import 'package:soon_sak/domain/useCase/register/request_content_registration_use_case.dart';
import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static Future<void> dependencies() async {
    // 버전
    Get.lazyPut(() => CheckVersionAndNetworkUseCase(Get.find(), Get.find()),
        fenix: true);

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
      () =>
          RequestContentRegistrationUseCase(Get.find(), Get.find(), Get.find()),
      fenix: true,
    );
    Get.lazyPut(() => LoadPagedCategoryCollectionUseCase(
        Get.find(), Get.find(), Get.find()));

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
    Get.lazyPut(() => NewSearchedPagedContentUseCase(Get.find()), fenix: true);
  }
}
