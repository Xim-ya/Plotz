import 'package:soon_sak/app/di/custom_binding.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDetailBinding extends CustomBindings {
  @override
  void dependencies() {
    super.dependencies();

    locator.registerFactory(() =>
        ContentDetailScaffoldController(locator<ContentDetailViewModel>()));

    locator.registerFactory(
      () => ContentDetailViewModel(
          contentRepository: locator<ContentRepository>(),
          loadContentOfVideoList: locator<LoadContentOfVideoListUseCase>(),
          loadContentImgList: locator<LoadContentImgListUseCase>(),
          loadContentMainDescription: locator<LoadContentDetailInfoUseCase>(),
          loadContentCreditInfo: locator<LoadContentCreditInfoUseCase>(),
          userRepository: locator<UserRepository>(),
          userService: locator<UserService>(),
          argument: argument),
    );

    locator.registerFactory(
        () => LoadContentDetailInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentCreditInfoUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentImgListUseCase(locator<TmdbRepository>()));
    locator.registerFactory(
        () => LoadContentOfVideoListUseCase(locator<ContentRepository>()));

    print("@@@@@@@@ 아지랑이");
  }

  @override
  void unRegisterDependencies() {
    super.unRegisterDependencies();

    locator.unregister<ContentDetailViewModel>();
    locator.unregister<ContentDetailScaffoldController>();
    locator.unregister<LoadContentDetailInfoUseCase>();
    locator.unregister<LoadContentCreditInfoUseCase>();
    locator.unregister<LoadContentImgListUseCase>();
    locator.unregister<LoadContentOfVideoListUseCase>();

    print("@@@@@@@ 아지랑이 dispose");
  }
}
