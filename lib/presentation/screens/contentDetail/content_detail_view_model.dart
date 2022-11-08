import 'package:flutter/material.dart';
import 'package:uppercut_fantube/presentation/base/base_view_model.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold.dart';
import 'package:uppercut_fantube/presentation/screens/contentDetail/content_detail_scaffold_controller.dart';

class ContentDetailViewModel extends BaseViewModel {

  FloatingActionButtonLocation floatingActionButtonLocation = FloatingActionButtonLocation.startTop;

  late ScrollController scrollController;



  // void changeFloatingBtnLocation() {
  //   if(scrollController.offset > 220){
  //     floatingActionButtonLocation = FloatingActionButtonLocation.endFloat;
  //     print("ARANG !!!!Î");
  //   }
  //
  //
  // }


  @override
  void onInit() {
    super.onInit();
     scrollController = ContentDetailScaffoldController.tabScrollController;

    scrollController.addListener(() {

      // changeFloatingBtnLocation();
    });
  }
}