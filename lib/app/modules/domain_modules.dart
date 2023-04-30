import 'package:soon_sak/domain/useCase/search/new_search_paged_content_use_case.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class DomainModules {
  DomainModules._();

  static Future<void> dependencies() async {
    // 버전
    Get.lazyPut(() => CheckVersionAndNetworkUseCase(Get.find(), Get.find()),
        fenix: false,);

    // 인증
    Get.lazyPut(() => SignInAndUpHandlerUseCase(Get.find(), Get.find()),
        fenix: false,);

    // Explore
    Get.lazyPut(
      () => LoadRandomPagedExploreContentsUseCase(Get.find(), Get.find()),
      fenix: true,
    );

    // Search
    Get.lazyPut(() => NewSearchedPagedContentUseCase(Get.find()), fenix: true);
  }
}
