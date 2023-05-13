import 'dart:developer';

import 'package:soon_sak/domain/useCase/version/check_version_and_network_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends BaseViewModel with FirestoreHelper {
  SplashViewModel(this._userService, this._contentService,
      this._localStorageService, this._checkVersionAndNetworkUseCase,);

  final UserService _userService;
  final ContentService _contentService;
  final LocalStorageService _localStorageService;

  /* UseCase */
  final CheckVersionAndNetworkUseCase _checkVersionAndNetworkUseCase;

  // 버전 및 네트워크 상태 확인
  Future<void> checkVersionAndNetwork() async {
    final response = await _checkVersionAndNetworkUseCase();
    response.fold(onSuccess: (data) {
      handleRoute();
    }, onFailure: (e) {
      log('버전 정보 및 네트워크 확인 실패');
    },);
  }

  void check({required GetPageBuilder page}) {
    assert(() {
      bool isLambda = false;

      try {
        final closure = page as dynamic;
        final closureType = closure.runtimeType;
        isLambda = closureType.toString().contains('=>');
      } catch (e) {
        // do nothing
      }

      if (!isLambda) {
        throw AssertionError(
            'Please use the correct syntax for creating the page instance. Instead of "TabsScreen.new", use "() => TabsScreen()".',);
      }

      return true;
    }());
  }



  // 라우팅 핸들러
  Future<void> handleRoute() async {

    await _userService.prepare();
    if (_userService.isUserSignIn) {
      await launchServiceModules().whenComplete(() {
        // 유저 접속일 최신화
        _userService.updateUserLoginDate(_userService.userInfo.value!.id!);
        Get.offAllNamed(AppRoutes.tabs);
      });
    } else {
      await launchServiceModules().whenComplete(() {
        Get.offAllNamed(AppRoutes.login);
      });
    }
  }

  /// 탭 스크린에 이동하기 전에 Splash 스크린에서
  /// load가 필요한 모듈들을 실행
  Future<void> launchServiceModules() async {
    await _contentService.prepare();
    await _localStorageService.prepare();
  }

  @override
  void onReady() {
    super.onReady();
    checkVersionAndNetwork();
  }
}
