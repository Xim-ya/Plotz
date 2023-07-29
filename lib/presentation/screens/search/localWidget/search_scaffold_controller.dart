import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

class SearchScaffoldController extends BaseViewModel {
  SearchScaffoldController({required SearchViewModel searchViewModel})
      : _searchViewModel = searchViewModel;

  /* View Model */
  final SearchViewModel _searchViewModel;
  int selectedTabIndex = 0;

  // /* Variables */
  /// 탭 인덱스가 변경될 때 마다
  /// 아래 1,2 메소들 실행
  Future<void> onTabClicked(int index) async {
    if (selectedTabIndex == index) {
      return;
    }
    selectedTabIndex = index;


    /// 탭이 전환 되었을 때
    /// paging call을 실행
    /// 바로 Paging call을 시도하면 call 두번 실행되는 이슈가 있음
    /// https://github.com/EdsonBueno/infinite_scroll_pagination/issues/136
    /// 두번 call 되는 이슈를 막기 위해 0.4초 delayed 한 뒤에 실행
    Future.delayed(
      const Duration(milliseconds: 400),
      () => {_searchViewModel.pagingController.refresh()},
    );
  }
}
