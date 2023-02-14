import 'package:soon_sak/presentation/screens/explore/explore_view_model.dart';
import 'package:soon_sak/presentation/screens/my/my_page_view_model.dart';
import 'package:soon_sak/presentation/screens/quration/quration_view_model.dart';
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

    // 검색
    // Get.lazyPut(() => SearchViewModel(), fenix: true);

    // 탐색
    Get.lazyPut(() => ExploreViewModel(Get.find(), Get.find()), fenix: true);

    // 큐레이션
    Get.lazyPut(() => QurationViewModel(), fenix: true);

    // 마에페이지
    Get.lazyPut(() => MyPageViewModel(Get.find()), fenix: true);

    // 큐레이션 내역
    Get.lazyPut(() => QurationHistoryViewModel(), fenix: true);
  }
}
