import 'package:soon_sak/presentation/screens/setting/setting_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingViewModel(Get.find(), Get.find(), Get.find()));
  }
}
