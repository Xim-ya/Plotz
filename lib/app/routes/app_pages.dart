// import 'package:go_router/go_router.dart';
// import 'package:soon_sak/presentation/screens/channel/channel_detail_binding.dart';
// import 'package:soon_sak/presentation/screens/channel/channel_detail_screen.dart';
// import 'package:soon_sak/presentation/screens/home/home_screen.dart';
// import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_binding.dart';
// import 'package:soon_sak/presentation/screens/profileSetting/profile_setting_screen.dart';
// import 'package:soon_sak/presentation/screens/search/search_binding.dart';
// import 'package:soon_sak/presentation/screens/search/search_screen.dart';
// import 'package:soon_sak/presentation/screens/setting/setting_binding.dart';
// import 'package:soon_sak/presentation/screens/setting/setting_screen.dart';
// import 'package:soon_sak/utilities/index.dart';
//
// /** Created By Ximya - 2022.11.04
//  *  - [GetPage]기반 라우팅 속성들을 해당 모듈에서 관리.
//  *  - GetPage속성에 [Bindings] 값을 걸어 Inject 할 수 있도록 함.
//  *  - [routes]에서 라우팅 페이지 이름 값들을 관리.
//  * */
//
// class SplashBindingOld extends Bindings {
//   @override
//   void dependencies() {
//     // TODO: implement dependencies
//   }
// }
//
// abstract class AppPages {
//   AppPages._();
//
//   static final routes = [
//     // 스플래쉬
//     GetPage(
//         name: AppRoutes.splash,
//         page: () => SplashScreen(),
//         binding: SplashBindingOld()),
//
//     // 로그인
//     // GetPage(
//     //     name: AppRoutes.login,
//     //     page: () => LoginScreen(),
//     //     binding: LoginBinding()),
//     //
//     // // 탭
//     // // GetPage(name: AppRoutes.tabs, page: TabsScreen.new, binding: TabsBinding()),
//     //
//     // // 홈
//     // // GetPage(
//     // //     name: AppRoutes.home,
//     // //     page: () => HomeScreen(),
//     // //     binding: TabsBinding(),
//     // //     children: [
//     // //       GetPage(
//     // //         name: AppRoutes.channelDetail,
//     // //         page: () => ChannelDetailScreen(),
//     // //         binding: ChannelDetailBinding(),
//     // //       )
//     // //     ]),
//     //
//     // // 컨텐츠 상세
//     // GetPage(
//     //   name: AppRoutes.contentDetail,
//     //   page: () => ContentDetailScreen(),
//     //   binding: ContentDetailBinding(),
//     // ),
//     //
//     // // 검색
//     // GetPage(
//     //   name: AppRoutes.search,
//     //   page: () => SearchScreen(),
//     //   binding: SearchBinding(),
//     // ),
//     //
//     // // 등록
//     // GetPage(
//     //   name: AppRoutes.register,
//     //   page: () => RegisterScreen(),
//     //   binding: RegisterBinding(),
//     // ),
//     //
//     // // 큐레이션 내력
//     // GetPage(
//     //   name: AppRoutes.curationHistory,
//     //   page: () => CurationHistoryScreen(),
//     //   binding: CurationHistoryBinding(),
//     // ),
//     //
//     // GetPage(
//     //   name: AppRoutes.setting,
//     //   page: () => SettingScreen(),
//     //   binding: SettingBinding(),
//     // ),
//     //
//     // GetPage(
//     //   name: AppRoutes.profileSetting,
//     //   page: () => ProfileSettingScreen(),
//     //   binding: ProfileSettingBinding(),
//     // )
//   ];
// }
