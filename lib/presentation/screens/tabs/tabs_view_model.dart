import 'dart:io';

import 'package:soon_sak/utilities/extensions/tab_loading_state_extension.dart';
import 'package:soon_sak/utilities/index.dart';

class TabsViewModel extends BaseViewModel {
  TabsViewModel(
      this._exploreViewModel, this._curationViewModel, this._myPageViewModel);

  /* ViewModels */
  final ExploreViewModel _exploreViewModel;
  final CurationViewModel _curationViewModel;
  final MyPageViewModel _myPageViewModel;

  /* Variables */

  /// State Variables
  // 네비게이션 바 인덱스
  RxInt selectedTabIndex = 0.obs;

  /* Intents */

  /// UI Interaction
  /// 네비게이션 바 아이템이 선택 되었을 때
  /// 탭별로 Api 호출을 나누기 위해 각 ViewModel prepare 메소드를 실행시킴
  /// 중복호출을 막기 위해 한번 호출된 메소드는 호출하지 않도록 예외처리
  void onBottomNavBarItemTapped(int index) async {
    selectedTabIndex(index);

    switch (index) {
      case 1:
        if (_exploreViewModel.loadingState.isInitState) {
          await _exploreViewModel.prepare();
        }
        break;
      case 2:
        if (_curationViewModel.loadingState.isInitState) {
          await _curationViewModel.prepare();
        }
        break;
      case 3:
        if (_myPageViewModel.loadingState.isInitState) {
          await _myPageViewModel.prepare();
        }
        break;
    }
  }
}
