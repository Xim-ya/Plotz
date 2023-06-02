import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soon_sak/app/routes/new_app_pages.dart';
import 'package:soon_sak/utilities/index.dart';
import 'presentation/common/layout/response_layout_builder.dart';

/** 2023.05.27
 * 1. HomeScreen Banner 비율로 변경 ✅
 * 2. 로그아웃 이후 다른 아아디로 로그인 하였을 때 발생하는 오류 수정 (오류 재현을 하기 힘듦)
 * 3. 마이페이지 시청기록 스켈레톤 로직 추가 ✅
 * 4. 다이어로그 UI 변경 대응, 구성 변경 ✅
 * 5. 버전 로직 개선 및 정리 ✅
 * 6. 불필요 코드 제거. 파일명 정리
 * 7. 프로필 설정 > 이름 유효성 검사 로직 수정. plotz에 맞게
 * */

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Oversized 이미지 확인 설정
    // debugInvertOversizedImages = true;

    // flutter build appbundle --target=lib/app/environment/devMain.dart --flavor dev

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Plotz',
      theme: ThemeConfig.basicTheme,
      routerConfig: NewAppPages.router,
      builder: (context, child) {
        // Initial Binding
        SizeConfig.to.init(context); // Size Config 초기화
        return ResponsiveLayoutBuilder(context, child);
      },
    );
  }
}
