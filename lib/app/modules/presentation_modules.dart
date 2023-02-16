import 'package:soon_sak/utilities/index.dart';

abstract class PresentationModules {
  PresentationModules._();

  static void dependencies() {
    // 탭 스크린
    Get.lazyPut(() => TabsViewModel(), fenix: true);
    Get.lazyPut(
        () => HomeViewModel(Get.find(), Get.find(), Get.find(), Get.find()),
        fenix: true);

    // 컨텐츠 상세화면
    Get.lazyPut(() => ContentDetailScaffoldController(), fenix: true);

    // 탐색
    Get.lazyPut(() => ExploreViewModel(Get.find(), Get.find()), fenix: true);

    // 큐레이션
    Get.lazyPut(() => CurationViewModel(), fenix: true);

    // 마에페이지
    Get.lazyPut(() => MyPageViewModel(Get.find()), fenix: true);

    // 큐레이션 내역
    Get.lazyPut(() => CurationHistoryViewModel(), fenix: true);
  }
}
