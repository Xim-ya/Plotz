enum SettingMenu {
  feedbackAndCs(name: '피드백 및 문의사항'),
  termsAndPolicy(name: '개인정보 및 약관'),
  logOut(name: '로그아웃'),
  withdrawal(name: '회원탈퇴');

  final String name;

  const SettingMenu({
    required this.name,
  });
}
