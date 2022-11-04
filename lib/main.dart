import 'package:uppercut_fantube/app/config/theme_config.dart';
import 'package:uppercut_fantube/app/di/app_binding.dart';
import 'package:uppercut_fantube/app/routes/app_routes.dart';
import 'package:uppercut_fantube/ui/screens/tabs/tabs_screen.dart';
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
      home: const TabsScreen()
    );
  }
}


