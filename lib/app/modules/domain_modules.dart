import 'package:soon_sak/domain/useCase/auth/sign_in_and_up_handler_use_case.dart';
import 'package:soon_sak/domain/useCase/auth/sign_out_use_case.dart';
import 'package:soon_sak/domain/useCase/content/load_cached_category_content_collection_use_case.dart';
import 'package:soon_sak/domain/useCase/content/load_cached_top_ten_contents_use_case.dart';
import 'package:soon_sak/domain/useCase/content/load_random_paged_explore_contents_use_case.dart';
import 'package:soon_sak/domain/useCase/search/search_paged_content_impl.dart';
import 'package:soon_sak/domain/useCase/search/validate_video_url_use_case_impl.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  // Service
  static Future<void> _preLoadDependencies() async{
    Get.put(ContentService(Get.find()));
    Get.put(LocalStorageService());
  }

  static void dependencies() {
    _preLoadDependencies();


    // 인증
    Get.lazyPut(() => SignOutUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SignInAndUpHandlerUseCase(Get.find()), fenix: true);

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
    // Get.lazyPut(() => SearchValidateUrlUseCase(), fenix: true);
    Get.lazyPut<SearchValidateUrlUseCase>(() => SearchValidateUrlImpl(),
        fenix: true);

    // Search
    Get.lazyPut<SearchPagedContentUseCase>(
        () => SearchPagedContentImpl(Get.find()),
        fenix: true);
  }


}
