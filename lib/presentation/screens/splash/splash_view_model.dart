import 'dart:developer';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends BaseViewModel {
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
      await onSignedInState().whenComplete(() {
        // 유저 접속일 최신화
        _userService.updateUserLoginDate();
        if (_userService.isOnboardingProgressDone) {
          context.go(AppRoutes.tabs);
          TabsBinding.dependencies();
        } else {
          context.go(AppRoutes.onboarding1);
        }
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

  /// 로그인된 상태에서 실행하는 이벤트
  /// 기본 서비스 모듈 초기화
  Future<void> onSignedInState() async {
    await launchServiceModules();
    await _userService.getUserInfo();
    await Future.wait([
      _userService.saveUserLocalDataIfNeeded(),
      _userService.checkOnBoardingProgressState()
    ]);
  }
}
