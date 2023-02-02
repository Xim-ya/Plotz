import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uppercut_fantube/app/config/theme_config.dart';
import 'package:uppercut_fantube/app/di/app_binding.dart';
import 'package:uppercut_fantube/app/routes/app_pages.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class Repository {}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Uppercut FanTube',
        theme: ThemeConfig.basicTheme,
        getPages: AppPages.routes,
        initialBinding: AppBinding(),
        initialRoute: AppRoutes.home,
        builder: (context, child) {
          SizeConfig.to.init(context); // Size Config 초기화
          return EasyLoading.init()(context, child);
        },
        home: const TabsScreen());
  }
}
