import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends BaseViewModel with FirestoreHelper {
  SplashViewModel(
      this._userService, this._contentService, this._localStorageService);

  final UserService _userService;
  final ContentService _contentService;
  final LocalStorageService _localStorageService;

  // 라우팅 핸들러
  Future<void> handleRoute() async {
    await _userService.prepare();
    if (_userService.isUserSignIn) {
      await launchServiceModules().whenComplete(() {
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
    handleRoute();
  }
}
