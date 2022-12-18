import 'package:uppercut_fantube/presentation/screens/search/search_binding.dart';
import 'package:uppercut_fantube/presentation/screens/search/search_screen.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.04
 *  - [GetPage]기반 라우팅 속성들을 해당 모듈에서 관리.
 *  - GetPage속성에 [Bindings] 값을 걸어 Inject 할 수 있도록 함.
 *  - [routes]에서 라우팅 페이지 이름 값들을 관리.
 * */

abstract class AppPages {
  AppPages._();

  static final routes = [
    // 탭
    // GetPage(name: AppRoutes.tabs, page: TabsScreen.new, binding: TabsBinding()),

    // 홈
    GetPage(
      name: AppRoutes.home,
      page: () => HomeScreen(),
      binding: TabsBinding(),
    ),

    // 컨텐츠 상세
    GetPage(
        name: AppRoutes.contentDetail,
        page: () => ContentDetailScreen(),
        binding: ContentDetailBinding()),

    // 검색
    GetPage(
        name: AppRoutes.search,
        page: () => SearchScreen(),
        binding: SearchBinding())
  ];
}
