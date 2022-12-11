import 'package:uppercut_fantube/domain/useCase/tmdb/load_content_credit_info_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/tmdb/load_content_img_list_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static void dependencies() {
    // 컨텐츠
    Get.lazyPut(() => LoadContentMainInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadTopExposedContentListUseCase(Get.find()),
        fenix: true);

    // TMDB
    Get.lazyPut(() => LoadContentMainDescriptionUseCase(Get.find()),
        fenix: true);
    Get.lazyPut(() => LoadContentCreditInfoUseCase(Get.find()), fenix: true);
    Get.lazyPut(() => LoadContentImgListUseCase(Get.find()), fenix: true);
  }
}
