import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/presentation/screens/onboarding/channel/channel_preferences_view_model.dart';

class ChannelPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(() => ChannelPreferencesViewModel());
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();

    locator.unregister<ChannelPreferencesViewModel>();
  }
}
