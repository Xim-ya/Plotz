import 'dart:developer';
import 'package:soon_sak/domain/enum/sns_type_enum.dart';
import 'package:soon_sak/domain/useCase/auth/sign_in_and_up_handler_use_case.dart';
import 'package:soon_sak/domain/useCase/auth/sign_out_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._signOutHandlerUseCase, this._signInHandlerUseCase);

  bool isUserSignIn = false;

  final SignOutUseCase _signOutHandlerUseCase;
  final SignInAndUpHandlerUseCase _signInHandlerUseCase;

  Future<void> checkUserState() async {}


  // 로그인 & 회원가입
  Future<void> signInAndUp(Sns social) async {
    final result = await _signInHandlerUseCase.call(social);
    result.fold(
      onSuccess: (data) {
        Get.offAllNamed(AppRoutes.tabs);
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  Future<void> logOut() async {
    await _signOutHandlerUseCase.call(Sns.google);
  }
}
