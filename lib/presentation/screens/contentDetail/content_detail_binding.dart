import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    safeRegisterFactory<ContentDetailViewModel>(
      () => ContentDetailViewModel(
        channelRepository: locator<ChannelRepository>(),
        loadContentMainDescription: locator<LoadContentDetailInfoUseCase>(),
        loadContentCreditInfo: locator<LoadContentCreditInfoUseCase>(),
        userRepository: locator<UserRepository>(),
        userService: locator<UserService>(),
        argument: arg1,
        loadContentVideoInfoUseCase: locator<LoadContentVideoInfoUseCase>(),
        updateUserPreferencesUserCase: locator<UpdateUserPreferencesUserCase>(),
      ),
    );

    safeRegisterFactory<LoadContentDetailInfoUseCase>(
        () => LoadContentDetailInfoUseCase(locator<TmdbRepository>()));

    safeRegisterFactory<LoadContentCreditInfoUseCase>(
        () => LoadContentCreditInfoUseCase(locator<TmdbRepository>()));

    safeRegisterFactory<LoadContentVideoInfoUseCase>(
        () => LoadContentVideoInfoUseCase(locator<ContentDataSource>()));

    safeRegisterFactory<UpdateUserPreferencesUserCase>(
      () => UpdateUserPreferencesUserCase(
        userRepository: locator<UserRepository>(),
      ),
    );
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    safeUnregister<ContentDetailViewModel>();
    safeUnregister<LoadContentDetailInfoUseCase>();
    safeUnregister<LoadContentCreditInfoUseCase>();
    safeUnregister<LoadContentVideoInfoUseCase>();
    safeUnregister<UpdateUserPreferencesUserCase>();
  }
}
