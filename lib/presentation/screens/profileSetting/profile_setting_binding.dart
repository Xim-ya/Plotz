import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileSettingViewModel(Get.find(), Get.find()));
  }
}
