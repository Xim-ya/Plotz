import 'package:soon_sak/app/environment/environment.dart';
import 'package:soon_sak/firebase_options.dart';
import 'package:soon_sak/firebase_options_dev.dart';
import 'package:soon_sak/utilities/index.dart';

/// Root
/// 초기화 메소드 순서 중요 (변경X)
void main() async {
  // Flutter Engine 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Isolate 토큰 생성 및 초기화
  final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  /// FireBase 초기화
  await Firebase.initializeApp(
    name: dotenv.env['FIREBASE_KEY_DEV'],
    options: DevFirebaseOptions.currentPlatform,
  );

  // Environment(BuildType.development);

  Get.put(AppAnalytics(), permanent: true);

  // Portrait 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    Environment(BuildType.development).run();
  });
}

