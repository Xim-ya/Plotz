import 'package:uppercut_fantube/domain/useCase/content/explore/load_explore_content_by_slider_index_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    // 컨텐츠
    // Get.lazyPut(() => LoadContentMainInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadTopExposedContentListUseCase(Get.find()),
        fenix: true);
    Get.lazyPut(() => ContentService(), fenix: true);

    // TMDB
    Get.lazyPut(() => LoadContentDetailInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentCreditInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentImgListUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadSearchedContentResultUseCase(Get.find()),
        fenix: true);
    Get.lazyPut(() => LoadExploreContentBySlierIndexUseCase(Get.find()),
        fenix: true);

    // Video
    Get.lazyPut(() => LoadContentOfVideoListUseCase(Get.find()), fenix: true);
  }
}
