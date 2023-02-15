import 'dart:developer';
import 'package:soon_sak/domain/enum/sns_type_enum.dart';
import 'package:soon_sak/domain/useCase/auth/sign_out_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageViewModel extends BaseViewModel {
  MyPageViewModel(this._signOutHandlerUseCase);

  final SignOutUseCase _signOutHandlerUseCase;

  /* Intents */
  // 큐레이팅 내역 스크린으로 라우팅
  void routeToQurationHistory() {
    Get.toNamed(AppRoutes.qurationHistory);
  }

  // 로그아웃
  Future<void> signOut(Sns social) async {
    final result = await _signOutHandlerUseCase.call(social);
    result.fold(onSuccess: (_) {
      Get.offAllNamed(AppRoutes.login);
    }, onFailure: (e) {
      AlertWidget.animatedToast('로그아웃에 실패했습니다. 다시 시도 시도해주세요');
      log(e.toString());
    });
  }
}
