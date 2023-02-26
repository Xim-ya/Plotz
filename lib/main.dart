import 'package:soon_sak/utilities/index.dart';
import 'firebase_options.dart';
import 'presentation/common/layout/response_layout_builder.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);
  await Firebase.initializeApp(
    name: 'soonsak-15350',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
      initialRoute: AppRoutes.splash,
      builder: (context, child) {
        SizeConfig.to.init(context); // Size Config 초기화
        return ResponsiveLayoutBuilder(context, child);
      },
    );
  }
}
