import 'package:uppercut_fantube/app/config/size_config.dart';
import 'package:uppercut_fantube/app/config/theme_config.dart';
import 'package:uppercut_fantube/app/di/app_binding.dart';

import 'package:uppercut_fantube/utilities/index.dart';


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
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.tabs,
        builder: (context, child) {
          SizeConfig.to.init(context); // Size Config 초기화
          return const SizedBox(); // <-- 단순 리턴을 위한 리턴
        },
      home: const TabsScreen()
    );
  }
}


