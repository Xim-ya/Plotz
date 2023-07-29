abstract class AppRoutes {
  AppRoutes._();

  // 스플래시
  static const splash = '/';

  // 로그인
  static const login = '/login';

  // 탭
  static const tabs = '/tabs';

  // 홈
  static const home = '/home';

  // 채널 상세
  static const channelDetail = '/channelDetail';

  // 컨텐츠 상세
  static const contentDetail = '/contentDetail';

  // 등록
  static const register = '/register';

  // 탐색
  static const explore = '/explore';

  // 설정
  static const setting = '/setting';

  // 프로필 설정
  static const profileSetting = '/profileSetting';

  // 유저 콘텐츠 취향 정보 수집(온보딩 1)
  static const onboarding1 = '/onboarding1';

  // 유저 채널 취향 정보 수집(온보딩 2)
  static const onboarding2 = '/onboarding2';

  /// 수집 종료 이후 Plotz 인트로 스크린
  static const onboarding3 = '/onboarding3';
}
