import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/routes/go_route_with_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_binding.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_screen.dart';
import 'package:soon_sak/presentation/screens/search/search_binding.dart';
import 'package:soon_sak/presentation/screens/search/search_screen.dart';
import 'package:soon_sak/presentation/screens/setting/setting_binding.dart';
import 'package:soon_sak/presentation/screens/setting/setting_screen.dart';
import 'package:soon_sak/presentation/screens/splash/splash_binding.dart';
import 'package:soon_sak/presentation/screens/temp_screen.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class NewAppPages {
  NewAppPages._();

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => LoginScreen()),
      // GoReplaceRouteWithBinding(
      //   path: AppRoutes.login,
      //   prevPath: '/',
      //   binding: LoginBinding(),
      //   newBuilder: (context, state) => const LoginScreen(),
      // ),
      // GoRouteWithBinding(
      //   path: AppRoutes.login,
      //   prevPath: AppRoutes.setting,
      //   binding: LoginBinding(),
      //   newBuilder: (context, state) => const LoginScreen(),
      // ),
      GoRoute(
        path: AppRoutes.tabs,
        builder: (context, state) => const TabsScreen(),
        routes: [
          GoRouteWithBinding(
            path: 'contentDetail',
            prevPath: AppRoutes.tabs,
            binding: ContentDetailBinding(),
            newBuilder: (context, state) => ContentDetailScreen(),
          ),
          GoRouteWithBinding(
            path: 'register',
            prevPath: AppRoutes.tabs,
            binding: RegisterBinding(),
            newBuilder: (context, state) => RegisterScreen(),
          ),
          GoRouteWithBinding(
            path: 'search',
            prevPath: AppRoutes.tabs,
            binding: SearchBinding(),
            newBuilder: (context, state) => SearchScreen(),
            routes: [
              GoRouteWithBinding(
                path: 'contentDetail',
                prevPath: AppRoutes.tabs + AppRoutes.search,
                binding: ContentDetailBinding(),
                newBuilder: (context, state) => ContentDetailScreen(),
              ),
            ],
          ),
          GoRouteWithBinding(
            path: 'curationHistory',
            prevPath: AppRoutes.tabs,
            binding: CurationHistoryBinding(),
            newBuilder: (context, state) => const CurationHistoryScreen(),
          ),
          GoRouteWithBinding(
            path: 'setting',
            prevPath: AppRoutes.tabs,
            binding: SettingBinding(),
            newBuilder: (context, state) => const SettingScreen(),
            routes: [
              GoRouteWithBinding(
                path: 'profileSetting',
                prevPath: AppRoutes.tabs + AppRoutes.setting,
                binding: ProfileSettingBinding(),
                newBuilder: (context, state) => const ProfileSettingScreen(),
              ),
            ],
          ),
        ],
      ),
      GoRouteWithBinding(
        path: AppRoutes.channelDetail,
        prevPath: AppRoutes.tabs,
        binding: ChannelDetailBinding(),
        newBuilder: (context, state) => ChannelDetailScreen(),
      ),
      GoRouteWithBinding(
        path: '/temp',
        prevPath: AppRoutes.channelDetail,
        binding: SplashBinding(),
        newBuilder: (context, state) => TempScreen(),
      ),
    ],
  );
}
