import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => ContentDetailViewModel(
        argument: Get.arguments,
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
        Get.find(),
      ),
      fenix: false,
    );

    // 컨텐츠 상세화면
    Get.lazyPut(() => ContentDetailScaffoldController(), fenix: false);

    // fenix를 true로 설정하는것도 고려해볼 수 있음
    Get.lazyPut(() => LoadContentDetailInfoUseCase(Get.find()), fenix: false);
    // Get.lazyPut(() => LoadContentCreditInfoUseCase(Get.find()), fenix: false);
    // Get.lazyPut(() => LoadContentImgListUseCase(Get.find()), fenix: false);
    // // Video
    // Get.lazyPut(() => LoadContentOfVideoListUseCase(Get.find()), fenix: true);

    // Get.put(LoadContentDetailInfoUseCase(Get.find()));
    Get.put(LoadContentCreditInfoUseCase(Get.find()));
    Get.put(LoadContentImgListUseCase(Get.find()));
    Get.put(LoadContentOfVideoListUseCase(Get.find()));
  }
}
