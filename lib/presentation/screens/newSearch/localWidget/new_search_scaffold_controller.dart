import 'package:soon_sak/presentation/screens/newSearch/new_search_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class NewSearchScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  NewSearchScaffoldController(this.searchViewModel);

  /* View Model */
  final NewSearchViewModel searchViewModel;
  int selectedTabIndex = 0;

  /* Controllers */
  late final TabController tabController;
  late final ScrollController scrollController;

  // /* Variables */
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

    /// 탭이 전환 되었을 때
    /// paging call을 실행
    /// 바로 Paging call을 시도하면 call 두번 실행되는 이슈가 있음
    /// https://github.com/EdsonBueno/infinite_scroll_pagination/issues/136
    /// 두번 call 되는 이슈를 막기 위해 0.4초 delayed 한 뒤에 실행
    Future.delayed(const Duration(milliseconds: 400),
        () => {searchViewModel.pagingController.refresh()});
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
  }
}
