import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/presentation/screens/requested_content/requested_content_board_binding.dart';
import 'package:soon_sak/presentation/screens/requested_content/requseted_content_board_screen.dart';
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
          AppRoutes.requestedContent,
        ],
        binding: ContentDetailBinding(),
        newBuilder: (context, state) => const ContentDetailScreen(),
      ),
      GoRouteWithBinding(
        path: AppRoutes.profileSetting,
        prevPath: const [
          AppRoutes.tabs,
        ],
        binding: ProfileSettingBinding(),
        newBuilder: (context, state) => const ProfileSettingScreen(),
      ),
      GoRouteWithBinding(
        path: AppRoutes.requestedContent,
        prevPath: const [
          AppRoutes.tabs,
        ],
        binding: RequestedContentBoardBinding(),
        newBuilder: (context, state) => const RequestedContentBoardScreen(),
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
      ),
    ],
  );
}
