import 'package:go_router/go_router.dart';
import 'package:soon_sak/app/routes/go_route_with_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
import 'package:soon_sak/presentation/screens/contentDetail/content_detail_screen.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_binding.dart';
import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_screen.dart';
import 'package:soon_sak/presentation/screens/search/search_binding.dart';
import 'package:soon_sak/presentation/screens/search/search_screen.dart';
import 'package:soon_sak/presentation/screens/setting/setting_binding.dart';
import 'package:soon_sak/presentation/screens/setting/setting_screen.dart';
import 'package:soon_sak/presentation/screens/splash/splash_binding.dart';
import 'package:soon_sak/presentation/screens/temp_screen.dart';
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
            path: 'register',
            prevPath: const [AppRoutes.tabs],
            binding: RegisterBinding(),
            newBuilder: (context, state) => const RegisterScreen(),
          ),
          GoRouteWithBinding(
            path: 'search',
            prevPath: const [AppRoutes.tabs],
            binding: SearchBinding(),
            newBuilder: (context, state) => const SearchScreen(),
          ),
          GoRouteWithBinding(
            path: 'curationHistory',
            prevPath: const [AppRoutes.tabs],
            binding: CurationHistoryBinding(),
            newBuilder: (context, state) => const CurationHistoryScreen(),
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
      // GoRoute(path: '/temp',
      //   builder: (_,__) => TempScreen(),
      // ),
    ],
  );
}

// import 'package:go_router/go_router.dart';
// import 'package:soon_sak/app/routes/go_route_with_binding.dart';
// import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
// import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
// import 'package:soon_sak/presentation/screens/contentDetail/content_detail_screen.dart';
// import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_binding.dart';
// import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_screen.dart';
// import 'package:soon_sak/presentation/screens/search/search_binding.dart';
// import 'package:soon_sak/presentation/screens/search/search_screen.dart';
// import 'package:soon_sak/presentation/screens/setting/setting_binding.dart';
// import 'package:soon_sak/presentation/screens/setting/setting_screen.dart';
// import 'package:soon_sak/presentation/screens/splash/splash_binding.dart';
// import 'package:soon_sak/presentation/screens/temp_screen.dart';
// import 'package:soon_sak/utilities/index.dart';
//
// abstract class NewAppPages {
//   NewAppPages._();
//
//   static final router = GoRouter(
//     debugLogDiagnostics: true,
//     initialLocation: '/',
//     routes: [
//       GoRoute(
//         path: '/',
//         builder: (_, __) => const SplashScreen(),
//       ),
//       GoRoute(path: AppRoutes.login, builder: (_, __) => const LoginScreen()),
//       GoRoute(
//         path: AppRoutes.tabs,
//         builder: (context, state) => const TabsScreen(),
//         routes: [
//           GoRouteWithBinding(
//             path: 'channelDetail',
//             prevPath: const [AppRoutes.tabs],
//             binding: ChannelDetailBinding(),
//             newBuilder: (context, state) => const ChannelDetailScreen(),
//           ),
//           GoRouteWithBinding(
//               path: 'contentDetail',
//               prevPath: const [
//                 AppRoutes.tabs,
//                 AppRoutes.contentDetail,
//               ],
//               binding: ContentDetailBinding(),
//               newBuilder: (context, state) => const NewContentDetailScreen(),
//               routes: [
//                 GoRouteWithBinding(
//                   path: 'channelDetail',
//                   prevPath: const [
//                     AppRoutes.channelDetail,
//                     AppRoutes.contentDetail
//                   ],
//                   binding: ChannelDetailBinding(),
//                   newBuilder: (context, state) => const ChannelDetailScreen(),
//                 ),
//               ]),
//           GoRouteWithBinding(
//             path: 'register',
//             prevPath: const [AppRoutes.tabs],
//             binding: RegisterBinding(),
//             newBuilder: (context, state) => const RegisterScreen(),
//           ),
//           GoRouteWithBinding(
//             path: 'search',
//             prevPath: const [AppRoutes.tabs],
//             binding: SearchBinding(),
//             newBuilder: (context, state) => const SearchScreen(),
//             routes: [
//               GoRouteWithBinding(
//                 path: 'contentDetail',
//                 prevPath: const [AppRoutes.tabs + AppRoutes.search],
//                 binding: ContentDetailBinding(),
//                 newBuilder: (context, state) => const NewContentDetailScreen(),
//               ),
//             ],
//           ),
//           GoRouteWithBinding(
//             path: 'curationHistory',
//             prevPath: const [AppRoutes.tabs],
//             binding: CurationHistoryBinding(),
//             newBuilder: (context, state) => const CurationHistoryScreen(),
//           ),
//           GoRouteWithBinding(
//             path: 'setting',
//             prevPath: const [AppRoutes.tabs],
//             binding: SettingBinding(),
//             newBuilder: (context, state) => const SettingScreen(),
//             routes: [
//               GoRouteWithBinding(
//                 path: 'profileSetting',
//                 prevPath: const [AppRoutes.tabs + AppRoutes.setting],
//                 binding: ProfileSettingBinding(),
//                 newBuilder: (context, state) => const ProfileSettingScreen(),
//               ),
//             ],
//           ),
//         ],
//       ),
//       // GoRoute(path: '/temp',
//       //   builder: (_,__) => TempScreen(),
//       // ),
//     ],
//   );
// }
