import 'package:get/get.dart';
import 'package:uppercut_fantube/app/routes/app_routes.dart';
import 'package:uppercut_fantube/ui/screens/tabs/tabs_binding.dart';
import 'package:uppercut_fantube/ui/screens/tabs/tabs_screen.dart';

/** Created By Ximya - 2022.11.04
 *  - [GetPage]기반 라우팅 속성들을 해당 모듈에서 관리.
 *  - GetPage속성에 [Bindings] 값을 걸어 Inject 할 수 있도록 함.
 *  - [routes]에서 라우팅 페이지 이름 값들을 관리.
 * */

abstract class AppPages {
  AppPages._();

  static final routes = [
    // 탭 스크린
    GetPage(name: AppRoutes.tabs, page: TabsScreen.new, binding: TabsBinding())
  ];


}