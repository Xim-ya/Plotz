import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/useCase/video/load_content_video_info_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(
      () => ContentDetailViewModel(
          channelRepository: locator<ChannelRepository>(),
          contentRepository: locator<ContentRepository>(),
          loadContentOfVideoList: locator<LoadContentOfVideoListUseCase>(),
          loadContentImgList: locator<LoadContentImgListUseCase>(),
          loadContentMainDescription: locator<LoadContentDetailInfoUseCase>(),
          loadContentCreditInfo: locator<LoadContentCreditInfoUseCase>(),
          userRepository: locator<UserRepository>(),
          userService: locator<UserService>(),
          argument: argument,
          loadContentVideoInfoUseCase: locator<LoadContentVideoInfoUseCase>()),
    );

    locator.registerFactory(
        () => LoadContentDetailInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentCreditInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentImgListUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentOfVideoListUseCase(locator<ContentRepository>()));
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();

    locator.unregister<ContentDetailViewModel>();
    locator.unregister<LoadContentDetailInfoUseCase>();
    locator.unregister<LoadContentCreditInfoUseCase>();
    locator.unregister<LoadContentImgListUseCase>();
    locator.unregister<LoadContentOfVideoListUseCase>();
  }
}
