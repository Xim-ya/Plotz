// import 'package:soon_sak/utilities/index_prev.dart';

import 'package:cupertino_will_pop_scope/cupertino_will_pop_scope.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

@immutable
class ThemeConfig {
  final _theme = ThemeData(
    splashColor: Colors.transparent,
    appBarTheme: const AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    // bottomSheetTheme: BottomSheetThemeData(
    //     backgroundColor: Colors.black.withOpacity(0)),

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
