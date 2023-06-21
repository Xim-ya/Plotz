import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/domain/useCase/onboarding/load_paged_preference_content_list.dart';
import 'package:soon_sak/presentation/screens/onboarding/content/content_preferences_view_model.dart';

class ContentPreferencesBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();
    locator.registerFactory(() => ContentPreferenceViewModel(
        loadPagedPreferenceContentListUseCase:
            locator<LoadPagedPreferenceContentListUseCase>()));
    locator.registerFactory(() => LoadPagedPreferenceContentListUseCase());
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    locator.unregister<ContentPreferenceViewModel>();
    locator.unregister<LoadPagedPreferenceContentListUseCase>();
  }
}
