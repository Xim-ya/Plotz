import 'dart:io';

import 'package:soon_sak/utilities/index.dart';

class TabsViewModel extends BaseViewModel {
  /* Variables */

  /// State Variables
  // 네비게이션 바 인덱스
  RxInt selectedTabIndex = 0.obs;

  /* Intents */

  /// UI Interaction
  // 네비게이션 바 아이템이 선택 되었을 때
  void onBottomNavBarItemTapped(int index) async {
    selectedTabIndex(index);
  }
}
