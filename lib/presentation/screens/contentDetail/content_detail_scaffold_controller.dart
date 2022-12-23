import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya  - 2022.11.07
 * [ContentDetailScaffold]에서 사용되는 UI Interaction들의 로직을 관리하는 Controller
 * [TabController] [ScrollController]을 기반으로 'StickyScrollTabView' 레이아웃을 구성
 * */

class ContentDetailScaffoldController extends BaseViewModel
    with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;

  /*** [State] Variables ***/
  // 선택된 탭 인덱스
  RxInt selectedTabIndex = 0.obs;

  // Sliver Custom 스크롤 Offset
  late Rxn<double> scrollOffset = Rxn();

  // 상단 '뒤로가기' 버튼 Visibility 여부
  RxBool showBackBtnOnTop = true.obs;

  /* 메소드 */
  // 탭 바 버튼이 클릭 되었을 때
  void onTabClicked(int index) {
    selectedTabIndex.value = index;
  }

  // [정보] 탭이 클릭 되었을 때 1회 필요한 api call 실행
  void fetchResourcesIfNeeded() {
    if (!ContentDetailViewModel.to.contentCreditList.hasData) {
      ContentDetailViewModel.to.fetchContentCreditInfo();
    }

    if (!ContentDetailViewModel.to.youtubeChannelInfo.value.hasData) {
      ContentDetailViewModel.to.fetchYoutubeChannelInfo();
    }

    if (!ContentDetailViewModel.to.contentImgUrlList.value.hasData) {
      ContentDetailViewModel.to.fetchContentImgList();
    }
  }

  // 하단 상단 앱바 Visibility 여부를 조절하는 메소드.
  void setBackBtnVisibility() {
    if (scrollController.offset >= 412 && showBackBtnOnTop.isTrue) {
      showBackBtnOnTop(false);
      return;
    } else if (scrollController.offset >= 482) {
      return;
    } else {
      if (showBackBtnOnTop.isFalse) {
        showBackBtnOnTop(true);
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    scrollController.addListener(() {
      setBackBtnVisibility();
      scrollOffset.value = scrollController.offset;
    });

    tabController.addListener(() {
      if (tabController.index == 1) {
        fetchResourcesIfNeeded();
      }
    });
  }

  double get headerBgOffset =>
      scrollOffset.value == null ? 0 : -scrollOffset.value! * 0.5;
}
