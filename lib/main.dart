import 'package:soon_sak/utilities/index.dart';
import 'firebase_options.dart';
import 'presentation/common/layout/response_layout_builder.dart';

/// Root
/// 초기화 메소드 순서 중요 (변경X)
void main() async {
  // Flutter Engine 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Isolate 토큰 생성 및 초기화
  final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // FireBase 초기화
  await runZonedGuarded<Future<void>>(() async {
    await Firebase.initializeApp(
      name: dotenv.env['FIREBASE_KEY']!,
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

    // Portrait 고정
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
        .then((_) {
      runApp(const MyApp());
    });
  }, (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack));
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
