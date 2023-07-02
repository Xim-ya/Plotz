import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/routes/go_route_with_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
import 'package:soon_sak/presentation/screens/onboarding/channel/channel_preferences_binding.dart';
import 'package:soon_sak/presentation/screens/onboarding/channel/channel_preferences_screen.dart';
import 'package:soon_sak/presentation/screens/onboarding/content/content_preferences_binding.dart';
import 'package:soon_sak/presentation/screens/onboarding/content/content_preferences_screen.dart';
import 'package:soon_sak/presentation/screens/onboarding/intro/intro_screen.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_binding.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_screen.dart';
import 'package:soon_sak/presentation/screens/search/search_binding.dart';
import 'package:soon_sak/presentation/screens/search/search_screen.dart';
import 'package:soon_sak/presentation/screens/setting/setting_binding.dart';
import 'package:soon_sak/presentation/screens/setting/setting_screen.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class AppPages {
  AppPages._();

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const SplashScreen(),
      ),
      GoRouteWithBinding(
        path: AppRoutes.onboarding1,
        binding: ContentPreferencesBinding(),
        newBuilder: (_, __) => const ContentPreferencesScreen(),
        prevPath: [],
      ),
      GoRouteWithBinding(
        path: AppRoutes.onboarding2,
        binding: ChannelPreferencesBinding(),
        newBuilder: (_, __) => const ChannelPreferencesScreen(),
        prevPath: const [AppRoutes.onboarding1],
      ),
      GoRoute(
        path: AppRoutes.onboarding3,
        builder: (_, __) => const IntroScreen(),
      ),
      GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
      GoRouteWithBinding(
        path: '/contentDetail',
        prevPath: const [
          AppRoutes.tabs,
          AppRoutes.channelDetail,
          AppRoutes.contentDetail,
        ],
        binding: ContentDetailBinding(),
        newBuilder: (context, state) => const ContentDetailScreen(),
      ),
      GoRouteWithBinding(
        path: '/channelDetail',
        prevPath: const [
          AppRoutes.tabs,
          AppRoutes.contentDetail,
        ],
        binding: ChannelDetailBinding(),
        newBuilder: (context, state) => const ChannelDetailScreen(),
      ),
      GoRoute(
        path: AppRoutes.tabs,
        builder: (context, state) => const TabsScreen(),
        routes: [
          GoRouteWithBinding(
            path: 'search',
            prevPath: const [AppRoutes.tabs],
            binding: SearchBinding(),
            newBuilder: (context, state) => const SearchScreen(),
          ),
          GoRouteWithBinding(
            path: 'setting',
            prevPath: const [AppRoutes.tabs],
            binding: SettingBinding(),
            newBuilder: (context, state) => const SettingScreen(),
            routes: [
              GoRouteWithBinding(
                path: 'profileSetting',
                prevPath: const [AppRoutes.tabs + AppRoutes.setting],
                binding: ProfileSettingBinding(),
                newBuilder: (context, state) => const ProfileSettingScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
