import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soon_sak/app/routes/new_app_pages.dart';
import 'package:soon_sak/utilities/index.dart';
import 'presentation/common/layout/response_layout_builder.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    debugInvertOversizedImages = true;

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Soon Sak',
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
