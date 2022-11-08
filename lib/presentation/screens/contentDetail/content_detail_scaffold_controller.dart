/** Created By Ximya  - 2022.11.07
 * [ContentDetailScaffold]에서 사용되는 UI Interaction들의 로직을 관리하는 Controller
 * [TabController] [ScrollController]을 기반으로 'StickyScrollTabView' 레이아웃을 구성
 * */

import 'package:uppercut_fantube/utilities/index.dart';

class ContentDetailScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;


  /* State Variables */
  RxInt selectedTabIndex = 0.obs;
  late double scrollOffset = 0;
  RxBool topPosition = false.obs;

  /* 메소드 */
  void onTabClicked(int index) {
    selectedTabIndex.value = index;

  }

  void changeFloatingBtnLocation() {
    if(scrollController.offset > 220){
      topPosition(true);
      print("arang");
    }


  }

  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
    scrollController = ScrollController();

    scrollController.addListener(() {

      changeFloatingBtnLocation();
    });


  }

  static ScrollController get tabScrollController => Get.find<ContentDetailScaffoldController>().scrollController;
}
