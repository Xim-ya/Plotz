import 'package:soon_sak/utilities/extensions/tab_loading_state_extension.dart';
import 'package:soon_sak/utilities/index.dart';

class TabsViewModel extends NewBaseViewModel {
  TabsViewModel({
    required ExploreViewModel exploreViewModel,
    required CurationViewModel curationViewModel,
    required MyPageViewModel myPageViewModel,
  })  : _exploreViewModel = exploreViewModel,
        _curationViewModel = curationViewModel,
        _myPageViewModel = myPageViewModel;

  /* ViewModels */
  final ExploreViewModel _exploreViewModel;
  final CurationViewModel _curationViewModel;
  final MyPageViewModel _myPageViewModel;

  /* Variables */

  /// State Variables
  // 네비게이션 바 인덱스
  int selectedTabIndex = 0;

  /* Intents */

  /// UI Interaction
  /// 네비게이션 바 아이템이 선택 되었을 때
  /// 탭별로 Api 호출을 나누기 위해 각 ViewModel prepare 메소드를 실행시킴
  /// 중복호출을 막기 위해 한번 호출된 메소드는 호출하지 않도록 예외처리
  Future<void> onBottomNavBarItemTapped(int index) async {
    selectedTabIndex = index;
    notifyListeners();

    switch (index) {
      case 0:
        unawaited(
          AppAnalytics.instance
              .logScreenView(screenClass: 'HomeScreen', screenName: 'HomeTab'),
        );
        break;
      case 1:
        unawaited(
          AppAnalytics.instance.logScreenView(
            screenClass: 'ExploreScreen',
            screenName: 'ExploreTab',
          ),
        );
        if (_exploreViewModel.loadingState.isInitState) {
          await _exploreViewModel.prepare();
        }
        break;
      case 2:
        unawaited(
          AppAnalytics.instance.logScreenView(
            screenClass: 'CurationScreen',
            screenName: 'CurationTab',
          ),
        );
        if (_curationViewModel.loadingState.isInitState) {
          await _curationViewModel.prepare();
        }
        break;
      case 3:
        unawaited(
          AppAnalytics.instance.logScreenView(
            screenClass: 'MyPageScreen',
            screenName: 'MyPageTab',
          ),
        );
        if (_myPageViewModel.loadingState.isInitState) {
          await _myPageViewModel.prepare();
        }
        break;
    }
  }

  // 탭 선택 여부
  bool isTabSelected(int index) => selectedTabIndex == index;
}
