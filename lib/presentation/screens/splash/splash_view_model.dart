import 'package:soon_sak/utilities/index.dart';

class SplashViewModel extends BaseViewModel with FirestoreHelper {
  SplashViewModel(this._userService, this._contentService);

  final UserService _userService;
  final ContentService _contentService;

  // 라우팅 핸들러
  Future<void> handleRoute() async {
    if (_userService.isUserSignIn) {
      await fetchTotalContentsId();
      await Get.offAllNamed(AppRoutes.tabs);
    } else {
      await Get.offAllNamed(AppRoutes.login);
    }
  }

  // 사전 호출
  // 모든 컨텐츠 아이디 리스트 호출
  Future<void> fetchTotalContentsId() async {
    await _contentService.prepare();
  }

  @override
  void onReady() {
    super.onReady();
    handleRoute();
  }
}
