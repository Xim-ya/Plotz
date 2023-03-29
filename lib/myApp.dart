import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soon_sak/utilities/index.dart';
import 'presentation/common/layout/response_layout_builder.dart';


class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soon Sak',
      theme: ThemeConfig.basicTheme,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: AppAnalytics.instance)
      ],
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        SizeConfig.to.init(context); // Size Config 초기화
        return ResponsiveLayoutBuilder(context, child);
      },
    );
  }
}
