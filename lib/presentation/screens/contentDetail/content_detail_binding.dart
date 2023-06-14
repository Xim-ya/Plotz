import 'package:soon_sak/app/di/binding.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/video/load_content_video_info_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends Bindings {
  @override
  void dependencies() {
    super.dependencies();

    safeRegisterFactory<ContentDetailViewModel>(() => ContentDetailViewModel(
          channelRepository: locator<ChannelRepository>(),
          loadContentMainDescription: locator<LoadContentDetailInfoUseCase>(),
          loadContentCreditInfo: locator<LoadContentCreditInfoUseCase>(),
          userRepository: locator<UserRepository>(),
          userService: locator<UserService>(),
          argument: arg1,
          loadContentVideoInfoUseCase: locator<LoadContentVideoInfoUseCase>(),
        ));

    safeRegisterFactory<LoadContentDetailInfoUseCase>(
        () => LoadContentDetailInfoUseCase(locator<TmdbRepository>()));

    safeRegisterFactory<LoadContentCreditInfoUseCase>(
        () => LoadContentCreditInfoUseCase(locator<TmdbRepository>()));

    safeRegisterFactory<LoadContentVideoInfoUseCase>(
        () => LoadContentVideoInfoUseCase(locator<ContentDataSource>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();
    safeUnregister<ContentDetailViewModel>();
    safeUnregister<LoadContentDetailInfoUseCase>();
    safeUnregister<LoadContentCreditInfoUseCase>();
    safeUnregister<LoadContentVideoInfoUseCase>();
  }
}
