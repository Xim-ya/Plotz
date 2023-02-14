import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:soon_sak/app/config/theme_config.dart';
import 'package:soon_sak/app/di/app_binding.dart';
import 'package:soon_sak/app/routes/app_pages.dart';
import 'package:soon_sak/data/firebase/app_fire_store.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    name: 'soonsak-15350',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Soon Sak',
      theme: ThemeConfig.basicTheme,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        SizeConfig.to.init(context); // Size Config 초기화
        return EasyLoading.init()(context, child);
      },
    );
  }
}
