import 'package:uppercut_fantube/utilities/index.dart';

class SearchScaffoldController extends BaseViewModel with GetSingleTickerProviderStateMixin {
  late final TabController tabController;
  late final ScrollController scrollController;



  @override
  void onInit() {
    super.onInit();

    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();
  }
}