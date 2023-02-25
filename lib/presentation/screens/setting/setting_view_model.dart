import 'dart:developer';

import 'package:soon_sak/utilities/index.dart';

class SettingViewModel extends BaseViewModel {
  SettingViewModel(this._signOutHandlerUseCase, this._userService);

  /* Data Modules */
  final UserService _userService;

  /* UseCase*/
  final SignOutUseCase _signOutHandlerUseCase;

  /* Intents */

  // 로그아웃
  Future<void> signOut() async {
    final userPlatform = _userService.userInfo!.provider!;
    final result = await _signOutHandlerUseCase.call(userPlatform);
    result.fold(
      onSuccess: (_) {
        Get.offAllNamed(AppRoutes.login);
      },
      onFailure: (e) {
        AlertWidget.animatedToast('로그아웃에 실패했습니다. 다시 시도 시도해주세요');
        log(e.toString());
      },
    );
  }

  // 프로필 설정 이동
  void routeToProfileSetting() {
    Get.toNamed(AppRoutes.profileSetting);
  }
}
