import 'package:get/get.dart';

class TestUseCase extends GetxController {
  RxBool testClosed = false.obs;

  Future<void> testLoop() async {
    for (var i = 0; i < 10055; i++) {
      if (testClosed.value == true) {
        break;
      }
      await Future.delayed(Duration(milliseconds: 500));
      // print('test ${i}');
    }
  }

  void disposeGetxController() {
    Get.delete<TestUseCase>();
    super.dispose();
  }
}
