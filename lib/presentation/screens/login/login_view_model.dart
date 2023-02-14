import 'dart:developer';
import 'package:soon_sak/domain/enum/sns_type_enum.dart';
import 'package:soon_sak/domain/useCase/auth/social_sign_in_handler_use_case.dart';
import 'package:soon_sak/domain/useCase/auth/social_sign_out_handler_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._signOutHandlerUseCase, this._signInHandlerUseCase);

  bool isUserSignIn = false;

  final SocialSignOutHandlerUseCase _signOutHandlerUseCase;
  final SocialSignInHandlerUseCase _signInHandlerUseCase;

  Future<void> checkUserState() async {}

  Future<void> socialSignIn(Sns social) async {
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
