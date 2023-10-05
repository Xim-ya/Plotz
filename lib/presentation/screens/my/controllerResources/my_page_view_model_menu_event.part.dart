part of '../my_page_view_model.dart';

/** Created By Ximya - 2023.07.02
 *  메뉴 선택 시 발생하는 메소드 모음
 * */

extension MyPageViewModelMenuEvent on MyPageViewModel {
  // 로그아웃 재확인 모달
  void _remindLogOutEvent() {
    showDialog(
      context: context,
      builder: (_) => AppDialog.dividedBtn(
        title: '로그아웃',
        description: '로그아웃 하시겠습니까?',
        leftBtnContent: '뒤로가기',
        rightBtnContent: '로그아웃',
        onLeftBtnClicked: context.pop,
        onRightBtnClicked: _logOut,
      ),
    );
  }

  // 회원탈퇴
  Future<void> withDrawUser() async {
    final response = await _userRepository.withdrawUser();
    response.fold(
      onSuccess: (data) {
        _logOut().whenComplete(() {
          clearUserLocalData();
          _userService.resetModule();
          AlertWidget.newToast(message: '회원탈퇴 처리 되었습니다', context);
        });
      },
      onFailure: (e) {
        log('SettingViewModel : $e');
      },
    );
  }

  // 이메일 피드백
  Future<void> _goToFeedbackPage() async {
    await launchUrl(
      Uri.parse('http://pf.kakao.com/_XVDxmxj/chat'),
      mode: LaunchMode.externalApplication,
    );
  }

  // 회원탈퇴 재확인 모달
  void _remindWithdrawalEvent() {
    showDialog(
      context: context,
      builder: (_) => AppDialog.dividedBtn(
        title: '회원 탈퇴',
        description: '탈퇴 시 개인정보가 삭제됩니다.\n정말 탈퇴하시겠습니까?',
        leftBtnContent: '뒤로가기',
        rightBtnContent: '정말요?',
        // TODO: 실제 요청 로직 추가 필요
        onRightBtnClicked: _againRemindWithdrawalEvent,
        onLeftBtnClicked: context.pop,
      ),
    );
  }

  // 회원탈퇴 재확인 모달
  void _againRemindWithdrawalEvent() {
    context.pop();
    showDialog(
      context: context,
      builder: (_) => AppDialog.dividedBtn(
        title: '회원 탈퇴',
        description: '정말 확실하시나요? 🥹',
        leftBtnContent: '뒤로가기',
        rightBtnContent: '회원탈퇴',
        // TODO: 실제 요청 로직 추가 필요
        onRightBtnClicked: withDrawUser,
        onLeftBtnClicked: context.pop,
      ),
    );
  }

  //개인정보 및 약관으로 이동
  Future<void> _goToTermAndPolicyPage() async {
    await launchUrl(
      Uri.parse(
        'https://puzzle-heather-876.notion.site/c2a63470f4ad471a95e57009ba9dfa3a',
      ),
      mode: LaunchMode.externalApplication,
    );
  }

  // 로그아웃
  Future<void> _logOut() async {
    final userPlatform = _userService.userInfo.value.provider!;
    final result = await _signOutHandlerUseCase.call(userPlatform);
    result.fold(
      onSuccess: (_) {
        context.go(AppRoutes.login);
        clearUserLocalData();
        _userService.resetModule();
        TabsBinding.unRegisterDependencies();
        LoginBinding.dependencies();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '로그아웃에 실패했습니다. 다시 시도 시도해주세요', context);
        log(e.toString());
      },
    );
  }
}
