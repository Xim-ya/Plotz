import 'package:soon_sak/utilities/index.dart';

class TabsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TabsViewModel(Get.find(), Get.find(), Get.find()));

    // Home
    Get.lazyPut(
      () => LoadCachedBannerContentUseCase(Get.find(), Get.find(), Get.find()),
      fenix: false,
    );

    Get.lazyPut(
      () => LoadPagedCategoryCollectionUseCase(
          Get.find(), Get.find(), Get.find()),
      fenix: false,
    );

    // 컨텐츠
    Get.put(
        LoadCachedTopTenContentsUseCase(Get.find(), Get.find(), Get.find()));
  }
}
