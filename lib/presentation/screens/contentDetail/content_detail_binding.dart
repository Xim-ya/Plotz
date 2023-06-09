import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/video/load_content_video_info_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(() => ContentDetailViewModel(
          channelRepository: locator<ChannelRepository>(),
          loadContentMainDescription: locator<LoadContentDetailInfoUseCase>(),
          loadContentCreditInfo: locator<LoadContentCreditInfoUseCase>(),
          userRepository: locator<UserRepository>(),
          userService: locator<UserService>(),
          argument: arg1,
          loadContentVideoInfoUseCase: locator<LoadContentVideoInfoUseCase>(),
        ));

    locator.registerFactory(
        () => LoadContentDetailInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentCreditInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentVideoInfoUseCase(locator<ContentDataSource>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    unregisterIfRegistered<ContentDetailViewModel>();
    unregisterIfRegistered<LoadContentDetailInfoUseCase>();
    unregisterIfRegistered<LoadContentCreditInfoUseCase>();
    unregisterIfRegistered<LoadContentVideoInfoUseCase>();
  }
}
