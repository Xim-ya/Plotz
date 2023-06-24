import 'package:hive_flutter/hive_flutter.dart';
import 'package:soon_sak/app/environment/environment.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/firebase_options_dev.dart';
import 'package:soon_sak/utilities/index.dart';

/// Root
/// 초기화 메소드 순서 중요 (변경X)
void main() async {
  // Flutter Engine 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  // Isolate 토큰 생성 및 초기화
  // final RootIsolateToken rootIsolateToken = RootIsolateToken.instance!;
  // BackgroundIsolateBinaryMessenger.ensureInitialized(rootIsolateToken);

  // get_it dependecies setup`
  AppBinding.dependencies();

  await Hive.initFlutter();
  Hive.registerAdapter(UserBoxAdapter());


  /// FireBase 초기화
  await Firebase.initializeApp(
    name: dotenv.env['FIREBASE_KEY_DEV'],
    options: DevFirebaseOptions.currentPlatform,
  );

  // Environment(BuildType.development);

  locator.registerFactory(() => AppAnalytics());
  await AppAnalytics.instance.setAnalyticsCollectionEnabled(false);

  // Portrait 고정
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    Environment(BuildType.development).run();
  });
}
