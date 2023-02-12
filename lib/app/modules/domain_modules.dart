import 'package:uppercut_fantube/domain/service/local_storage_service.dart';
import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/domain/useCase/auth/social_sign_in_handler_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/auth/social_sign_out_handler_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/content/load_cached_category_content_collection_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/content/load_cached_top_ten_contents_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/explore/test_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/search/search_paged_content_impl.dart';
import 'package:uppercut_fantube/domain/useCase/search/validate_video_url_use_case_impl.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    // 로컬 스토리지
    Get.put(LocalStorageService());

    // 인증
    Get.lazyPut(() => SocialSignOutHandlerUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => SocialSignInHandlerUseCase(Get.find()), fenix: true);

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
    Get.lazyPut(() => TestUseCase(), fenix: true);

    // Register
    // Get.lazyPut(() => SearchValidateUrlUseCase(), fenix: true);
    Get.lazyPut<SearchValidateUrlUseCase>(() => SearchValidateUrlImpl(),
        fenix: true);

    // Search
    Get.lazyPut<SearchPagedContentUseCase>(
        () => SearchPagedContentImpl(Get.find()),
        fenix: true);


    // Service
    Get.lazyPut(() => UserService(Get.find()), fenix: true);
    Get.put(ContentService());
  }
}
