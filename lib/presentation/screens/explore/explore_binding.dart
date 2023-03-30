import 'package:get/get.dart';
import 'package:soon_sak/domain/useCase/explore/load_random_paged_explore_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/explore/explore_view_model.dart';

class ExploreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreViewModel(Get.find()));


  }

}