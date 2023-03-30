import 'package:soon_sak/utilities/index.dart';

class CurationHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => CurationHistoryViewModel(Get.find(), Get.find()),
      fenix: false,
    );
  }
}
