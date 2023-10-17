import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

import 'presentation/common/layout/response_layout_builder.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Oversized 이미지 확인 설정

    // debugInvertOversizedImages = true;

    // (ios) 가끔 firestore sdk가 flavor에 맞게 전환이 안될 떄 있음
    // 아래 명령어 사용
    // flutter build appbundle --target=lib/app/environment/devMain.dart --flavor dev
    // flutter build appbundle --target=lib/app/environment/prodMain.dart --flavor prod
    // flutter run ios --target=lib/app/environment/prodMain.dart --flavor prod

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Plotz',
      theme: ThemeConfig.basicTheme,
      routerConfig: AppPages.router,
      builder: (context, child) {
        // Initial Binding
        SizeConfig.to.init(context); // Size Config 초기화
        return ResponsiveLayoutBuilder(context, child);
      },
    );
  }
}
