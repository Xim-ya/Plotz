import 'package:go_router/go_router.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya  - 2022.11.07
 * [ContentDetailScaffold]에서 사용되는 UI Interaction들의 로직을 관리하는 Controller
 * [TabController] [ScrollController]을 기반으로 'StickyScrollTabView' 레이아웃을 구성
 * */

class ContentDetailScaffoldController extends NewBaseViewModel {
  ContentDetailScaffoldController(this.contentDetailViewModel);

  final ContentDetailViewModel contentDetailViewModel;


  late final TabController tabController;
  final ScrollController scrollController = ScrollController();

  /*** [State] Variables ***/
  // 선택된 탭 인덱스
  int selectedTabIndex = 0;

  // Sliver Custom 스크롤 Offset
  double scrollOffset = 0;

  // 상단 '뒤로가기' 버튼 Visibility 여부
  bool showBackBtnOnTop = true;

  /* 메소드 */
  // 탭 바 버튼이 클릭 되었을 때
  void onTabClicked(int index) {
    selectedTabIndex = index;
  }

  // [정보] 탭이 클릭 되었을 때 1회 필요한 api call 실행
  void fetchResourcesIfNeeded() {
    if (tabController.index == 1) {
      contentDetailViewModel.fetchContentCreditInfo();
      contentDetailViewModel.fetchCuratorInfo();
      contentDetailViewModel.fetchContentImgList();
      tabController.removeListener(fetchResourcesIfNeeded);
    }
  }

  // 뒤로가기
  void onRouteBack(BuildContext context) {
    context.pop();
  }

  // 하단 상단 앱바 Visibility 여부를 조절하는 메소드.
  void setBackBtnVisibility() {
    if (scrollController.offset >= 412 && showBackBtnOnTop == true) {
      showBackBtnOnTop = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 482) {
      return;
    } else {
      if (showBackBtnOnTop == false) {
        showBackBtnOnTop = true;
        notifyListeners();
      }
    }
  }

  void onIntentInit(TabController passedTabC) {
    scrollController.addListener(() {
      setBackBtnVisibility();
      scrollOffset = scrollController.offset;
      if (scrollController.offset <= 412) {
        notifyListeners();
      }
    });
    tabController = passedTabC;
    tabController.addListener(fetchResourcesIfNeeded);
  }

  // @override
  // void onClose() {
  //   tabController.dispose();
  //   scrollController.dispose();
  //   super.onClose();
  // }

  double get headerBgOffset => -scrollOffset * 0.5;
}
