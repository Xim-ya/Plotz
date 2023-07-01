import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(
      {required UserService userService,
      required SignInAndUpHandlerUseCase signInHandlerUseCase})
      : _userService = userService,
        _signInHandlerUseCase = signInHandlerUseCase;

  bool isUserSignIn = false;

  /* Data Modules */
  final UserService _userService;

  /* UseCases */
  final SignInAndUpHandlerUseCase _signInHandlerUseCase;

  // 로그인 & 회원가입
  Future<void> signInAndUp(Sns social) async {
    final result = await _signInHandlerUseCase.call(social, context);
    await result.fold(
      onSuccess: (data) async {
        await launchServiceModules().whenComplete(() {
          _userService.updateUserLoginDate();
          if (_userService.isOnboardingProgressDone) {
            context.go(AppRoutes.tabs);
            TabsBinding.dependencies();
            LoginBinding.unRegisterDependencies();
          } else {
            context.go(AppRoutes.onboarding1);
          }
        });
      },
      onFailure: (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('로그인이 중단되었습니다'),
          action: SnackBarAction(
            label: '확인',
            onPressed: () {},
          ),
        ));
        log(e.toString());
      },
    );
  }

  /// 탭 스크린에 이동하기 전에 Splash 스크린에서
  /// load가 필요한 모듈들을 실행
  Future<void> launchServiceModules() async {
    await _userService.getUserInfo();
    await _userService.saveUserLocalDataIfNeeded();
    await _userService.checkOnBoardingProgressState();
  }
}
