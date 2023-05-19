import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/routes/go_route_with_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
import 'package:soon_sak/presentation/screens/search/search_binding.dart';
import 'package:soon_sak/presentation/screens/search/search_screen.dart';
import 'package:soon_sak/presentation/screens/splash/splash_binding.dart';
import 'package:soon_sak/presentation/screens/temp_screen.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class NewAppPages {
  NewAppPages._();

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRouteWithBinding(
        path: '/',
        binding: SplashBinding(),
        newBuilder: (context, state) => const SplashScreen(),
      ),
      GoReplaceRouteWithBinding(
          path: AppRoutes.tabs,
          binding: TabsBinding(),
          newBuilder: (context, state) => const TabsScreen(),
          routes: [
            GoRouteWithBinding(
              path: 'search',
              prevPath: AppRoutes.tabs,
              binding: SearchBinding(),
              newBuilder: (context, state) => SearchScreen(),
            ),
          ]),
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
