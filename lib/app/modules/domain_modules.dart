import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/domain/useCase/explore/test_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/search/search_paged_content_impl.dart';
import 'package:uppercut_fantube/domain/useCase/search/validate_video_url_use_case_impl.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    // 컨텐츠
    Get.lazyPut(() => LoadTopExposedContentListUseCase(Get.find()),
        fenix: true);
    Get.lazyPut(() => ContentService(), fenix: true);
    Get.lazyPut(() => PartialLoadContentUseCase(Get.find()), fenix: true);

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

    Get.lazyPut(() => UserService(), fenix: true);
  }
}
