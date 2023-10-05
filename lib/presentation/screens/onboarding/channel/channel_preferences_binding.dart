import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/data/repository/channel/channel_repository.dart';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/domain/service/user_service.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_preferences_channel_list_use_case.dart';
import 'package:soon_sak/domain/useCase/onboarding/update_onboarding_preferences_use_case.dart';
import 'package:soon_sak/presentation/screens/onboarding/channel/channel_preferences_view_model.dart';

class ChannelPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(
      () => ChannelPreferencesViewModel(
        loadChannelsUseCase: locator<LoadPagedPreferenceChannelListUseCase>(),
        updateUserPreferencesUseCase:
            locator<UpdateOnboardingPreferencesUseCase>(),
        userService: locator<UserService>(),
      ),
    );
    locator.registerFactory(() => LoadPagedPreferenceChannelListUseCase(
        channelRepository: locator<ChannelRepository>()));

    locator.registerFactory(
      () => UpdateOnboardingPreferencesUseCase(
        selectedContents: arg1,
        userRepository: locator<UserRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();

    locator.unregister<ChannelPreferencesViewModel>();
    locator.unregister<LoadPagedPreferenceChannelListUseCase>();
    locator.unregister<UpdateOnboardingPreferencesUseCase>();
  }
}
