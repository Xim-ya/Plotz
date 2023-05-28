import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ProfileSettingBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(
      () => ProfileSettingViewModel(
        userService: locator<UserService>(),
        userRepository: locator<UserRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<ProfileSettingViewModel>();
  }
}
