import 'package:soon_sak/utilities/index.dart';

abstract class PresentationModules {
  PresentationModules._();

  static void dependencies() {
    // 홈 (탭 스크린)
    Get.lazyPut(() => HomeViewModel(Get.find(), Get.find(), Get.find()),
        fenix: true);

    // 탐색
    Get.lazyPut(() => ExploreViewModel(Get.find()), fenix: true);

    // 큐레이션
    Get.lazyPut(() => CurationViewModel(Get.find()), fenix: true);

    // 마에페이지
    Get.lazyPut(() => MyPageViewModel(Get.find(), Get.find()),
        fenix: true);
  }
}
