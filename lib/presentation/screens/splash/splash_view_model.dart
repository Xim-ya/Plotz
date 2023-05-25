import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/environment/devMain.dart';
import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends NewBaseViewModel {
  SplashViewModel({
    required UserService userService,
    required ContentService contentService,
    required LocalStorageService localStorageService,
    required CheckVersionAndNetworkUseCase checkVersionAndNetworkUseCase,
  })  : _userService = userService,
        _contentService = contentService,
        _localStorageService = localStorageService,
        _checkVersionAndNetworkUseCase = checkVersionAndNetworkUseCase;

  /* State Variable */
  bool isViewModelMounted = false;

  /* Services */
  final UserService _userService;
  final ContentService _contentService;
  final LocalStorageService _localStorageService;

  /* UseCase */
  final CheckVersionAndNetworkUseCase _checkVersionAndNetworkUseCase;

  // 버전 및 네트워크 상태 확인
  Future<void> checkVersionAndNetwork(BuildContext context) async {
    if (isViewModelMounted == true) return;
    isViewModelMounted = true;

    final response = await _checkVersionAndNetworkUseCase(context);
    response.fold(
      onSuccess: (data) {
        handleRoute(context);
      },
      onFailure: (e) {
        log('버전 정보 및 네트워크 확인 실패');
      },
    );
  }


  // 라우팅 핸들러
  Future<void> handleRoute(BuildContext context) async {
    await _userService.prepare(context);
    if (_userService.isUserSignIn) {
      await launchServiceModules().whenComplete(() {
        // 유저 접속일 최신화
        _userService.updateUserLoginDate(_userService.userInfo.value.id!);
        context.go(AppRoutes.tabs);
        TabsBinding.dependencies();
      });
    } else {
      await launchServiceModules().whenComplete(() {
        context.go(AppRoutes.login);
        LoginBinding.dependencies();
      });
    }
  }

  /// 탭 스크린에 이동하기 전에 Splash 스크린에서
  /// load가 필요한 모듈들을 실행
  Future<void> launchServiceModules() async {
    await _contentService.prepare();
    await _localStorageService.prepare();
  }
}
