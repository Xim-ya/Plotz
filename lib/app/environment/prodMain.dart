import 'package:hive_flutter/hive_flutter.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/firebase_options.dart';
import 'package:soon_sak/utilities/index.dart';

/// Root
/// 초기화 메소드 순서 중요 (변경X)
void main() async {
  // Flutter Engine 초기화
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  /// FireBase 초기화
  // Firebase Crashlytics 설정
  await runZonedGuarded<Future<void>>(
    () async {
      // get_it dependecies setup`
      AppBinding.dependencies();

      await Hive.initFlutter();
      Hive.registerAdapter(UserBoxAdapter());

      await Hive.initFlutter();

      await Firebase.initializeApp(
        name: dotenv.env['FIREBASE_KEY'],
        options: ProdFirebaseOptions.currentPlatform,
      );

      FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

      locator.registerFactory(() => AppAnalytics());
      await AppAnalytics.instance.setAnalyticsCollectionEnabled(true);
      await AppAnalytics.instance.logAppOpen();

      // Portrait 고정
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]).then((_) {
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
        Environment(BuildType.production).run();
      });
    },
    (error, stack) => FirebaseCrashlytics.instance.recordError(error, stack),
  );
}
