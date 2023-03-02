import 'dart:developer';

import 'package:soon_sak/utilities/index.dart';

class SettingViewModel extends BaseViewModel {
  SettingViewModel(
      this._signOutHandlerUseCase, this._userService, this._userRepository);

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* UseCase*/
  final SignOutUseCase _signOutHandlerUseCase;

  /* Intents */

  // 회원탈퇴
  Future<void> withDrawUser() async {
    final response =
        await _userRepository.withdrawUser(_userService.userInfo.value!.id!);
    response.fold(onSuccess: (data) {
      signOut().whenComplete(() {
        AlertWidget.animatedToast('회원탈퇴 처리 되었습니다');
      });
    }, onFailure: (e) {
      log('SettingViewModel : $e');
    });
  }

  //개인정보 및 약관으로 이동
  Future<void> routeToTerms() async {
    await launchUrl(
      Uri.parse(
          'https://puzzle-heather-876.notion.site/c2a63470f4ad471a95e57009ba9dfa3a'),
      mode: LaunchMode.externalApplication,
    );
  }

  // 이메일 피드백
  void goToKakaoOneonOne() async {
    await launchUrl(
      Uri.parse('http://pf.kakao.com/_XVDxmxj/chat'),
      mode: LaunchMode.externalApplication,
    );
  }

  // 회원탈퇴 안내 모달
  void showWithdrawnInoModal() {
    Get.dialog(
      AppDialog.dividedBtn(
        title: '회원 탈퇴',
        description: '탈퇴 시 기존 큐레이팅 내역 및 개인정보가 삭제됩니다.\n정말 탈퇴하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '탈퇴',
        // TODO: 실제 요청 로직 추가 필요
        onRightBtnClicked: withDrawUser,
        onLeftBtnClicked: Get.back,
      ),
    );
  }

  // 로그아웃
  Future<void> signOut() async {
    final userPlatform = _userService.userInfo.value!.provider!;
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

  /* Getters */
  String get currentVersionNum => _userService.currentVersionNum;
}
