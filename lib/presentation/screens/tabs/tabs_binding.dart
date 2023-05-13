import 'package:soon_sak/domain/useCase/content/home/load_cached_top_positioned_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TabsViewModel(Get.find(), Get.find(), Get.find()),
        fenix: true);

    Get.put(
      LoadCachedTopPositionedContentsUseCase(
          Get.find(), Get.find(), Get.find()),
    );
  }
}
