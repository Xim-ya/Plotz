import 'package:get/get.dart';
import 'package:soon_sak/presentation/screens/explore/explore_view_model.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreViewModel(Get.find()));


  }

}