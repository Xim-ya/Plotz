import 'package:uppercut_fantube/utilities/index.dart';

class HomeViewModel extends BaseViewModel {
  /* Variables */

  /// State
  late double scrollOffset = 0;
  final RxBool showAppbarBackground = true.obs;
  RxBool showBlurAtAppBar = false.obs;

  /// Size
  final double appBarHeight = SizeConfig.to.statusBarHeight + 56;

  ///  Controllers
  late ScrollController scrollController;

  /* Intent */
  /// UI Intent Method
  // AppBar Blur효과 avtivate 여부
  void turnOnBlurInAppBar() {
    // Status Bar Height 보다 offest이 작을 땐 Blur 처리 X
    if (scrollOffset <= SizeConfig.to.statusBarHeight) {
      showBlurAtAppBar(false);
      return;
    } else {
      /** 중복 할당을 방지하기 위해. 조건 두가지를 추가.
       * [scrollController.position.userScrollDirection] 유저가 아래로 스크롤하고
       * [showBlurAtAppBar.isTrue] blur값이 true로 선언되어 있다면 값을 변경.
       * */
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward && showBlurAtAppBar.isTrue) {
          showBlurAtAppBar(false);
        return;
      } else if  (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse && showBlurAtAppBar.isFalse){
        showBlurAtAppBar(true);
        return;
      }
    }
  }



  @override
  void onInit() {
    super.onInit();
    print("ARANG");
    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      turnOnBlurInAppBar();
    });
  }
}
