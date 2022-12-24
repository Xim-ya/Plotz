import 'package:uppercut_fantube/presentation/screens/search/search_view_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class SearchScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;

  // 선택된 탭 (컨텐츠 타입)
  ContentType _selectedTabType = ContentType.tv;

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    /// 탭 인덱스가 변경될 때 마다
    /// 아래 1,2 메소들 실행
    tabController.addListener(
      () {
        print("TAB CHANGED!! ${tabController.index}");
        // 1. paiginController 리셋
        // SearchViewModel.resetPagingValue;

        // 2. 타입별로 Api을 하기 위해 컨텐츠 타입을 변경.
        if (tabController.index == 0) {
          _selectedTabType = ContentType.tv;

        } else {
          _selectedTabType = ContentType.movie;
        }

        SearchViewModel.to.refreshPagingController();

      },
    );
  }

  /* Getters */

  // 선택된 탭 (컨텐츠 타입) - [SearchViewModel]에서 사용.
  static ContentType get selectedTabType =>
      Get.find<SearchScaffoldController>()._selectedTabType;
}
