import 'package:soon_sak/utilities/index.dart';

class CurationHistoryViewModel extends BaseViewModel with GetSingleTickerProviderStateMixin {

  late final TabController tabController;


  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 3, vsync: this);
  }
}