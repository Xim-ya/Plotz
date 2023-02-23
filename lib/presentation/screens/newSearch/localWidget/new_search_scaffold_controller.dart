import 'package:soon_sak/presentation/screens/newSearch/new_search_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class NewSearchScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;

  /* View Model */
  final NewSearchViewModel searchViewModel;
  int selectedTabIndex = 0;

  /* Controllers */


  NewSearchScaffoldController(this.searchViewModel);

  // /* Variables */
  // ContentType _selectedTabType = ContentType.tv; // 선택된 탭 (컨텐츠 타입)

  /// 탭 인덱스가 변경될 때 마다
  /// 아래 1,2 메소들 실행
  void onTabClicked(int index) {
    if (selectedTabIndex == index) {
      return;
    }
    selectedTabIndex = index;
    if (index == 0) {
      searchViewModel.selectedTabType.value = ContentType.tv;
    } else {
      searchViewModel.selectedTabType.value = ContentType.movie;
    }
    Future.delayed(
        const Duration(milliseconds: 400), () => {searchViewModel.pagingController.refresh()});
  }

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    /// 탭 인덱스가 변경될 때 마다
    /// 아래 1,2 메소들 실행
  }
}
