import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._signOutHandlerUseCase, this._signInHandlerUseCase,
      this._userService);

  bool isUserSignIn = false;

  /* Data Modules */
  final UserService _userService;

  /* UseCases*/
  final SignOutUseCase _signOutHandlerUseCase;
  final SignInAndUpHandlerUseCase _signInHandlerUseCase;

  Future<void> checkUserState() async {}

  Future<void> aim() async{
    Get.offAllNamed(AppRoutes.tabs);
  }

  // 로그인 & 회원가입
  Future<void> signInAndUp(Sns social) async {
    final result = await _signInHandlerUseCase.call(social);
    await result.fold(
      onSuccess: (data) async {
        await launchServiceModules().whenComplete(() {
          Get.offAllNamed(AppRoutes.tabs);
        });
      },
      onFailure: (e) {
        Get.snackbar('로그인이 중단되었습니다', '다시 시도해주세요');
        log(e.toString());
      },
    );
  }

  Future<void> logOut() async {
    await _signOutHandlerUseCase.call(Sns.google);
  }

  /// 탭 스크린에 이동하기 전에 Splash 스크린에서
  /// load가 필요한 모듈들을 실행
  Future<void> launchServiceModules() async {
    await _userService.getUserInfo();
  }
}
