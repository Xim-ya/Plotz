import 'package:flutter/rendering.dart';
import 'package:uppercut_fantube/app/config/size_config.dart';
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


  // Intent
  /// UI Intent Method
  void turnOnBlurInAppBar() {
    if (scrollOffset == 0) {
      showBlurAtAppBar(false);
      return;
    } else {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        showBlurAtAppBar(false);
        return;
      } else {
        showBlurAtAppBar(true);

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
