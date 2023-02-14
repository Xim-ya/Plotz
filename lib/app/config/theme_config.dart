import 'package:soon_sak/utilities/index.dart';

class ThemeConfig {
  final _theme = ThemeData(
    // 플랫폼별 라우팅 애니메이션 속성
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: ZoomPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoWillPopScopePageTransionsBuilder(),
      },
    ),
  );

  static ThemeData get basicTheme => ThemeConfig()._theme;
}
