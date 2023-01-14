import 'package:uppercut_fantube/presentation/screens/explore/explore_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class PresentationModules {
  PresentationModules._();

  static void dependencies() {
    // 탭 스크린
    Get.lazyPut(() => TabsViewModel(), fenix: true);
    Get.lazyPut(() => HomeViewModel(Get.find(), Get.find()), fenix: true);

    // 컨텐츠 상세화면
    Get.lazyPut(() => ContentDetailScaffoldController(), fenix: true);

    // 검색
    // Get.lazyPut(() => SearchViewModel(), fenix: true);

    // 탐색
    Get.lazyPut(() => ExploreViewModel(Get.find()), fenix: true);
  }
}
