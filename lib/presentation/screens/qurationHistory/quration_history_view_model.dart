import 'package:uppercut_fantube/utilities/index.dart';

class QurationHistoryViewModel extends BaseViewModel with GetSingleTickerProviderStateMixin {

  late final TabController tabController;


  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
  }
}