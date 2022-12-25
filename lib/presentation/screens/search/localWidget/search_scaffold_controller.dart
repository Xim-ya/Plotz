import 'package:uppercut_fantube/utilities/index.dart';

class SearchScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;


  /* State Variables */
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
        // 1. 타입별로 Api을 하기 위해 컨텐츠 타입을 변경.
        if (tabController.index == 0) {
          _selectedTabType = ContentType.tv;
        } else {
          _selectedTabType = ContentType.movie;
        }

        /// 2. paiginController 리셋
        /// 검색어가 없다면 refresh 하지 않음.
        if (SearchViewModel.to.textEditingController.text.isNotEmpty) {
          SearchViewModel.to.refreshPagingController();
        }
      },
    );
  }

  /* Getters */

  // 선택된 탭 (컨텐츠 타입) - [SearchViewModel]에서 사용.
  static ContentType get selectedTabType =>
      Get.find<SearchScaffoldController>()._selectedTabType;
}
