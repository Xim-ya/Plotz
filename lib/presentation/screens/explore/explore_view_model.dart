import 'dart:developer';

import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:soon_sak/data/mixin/isolate_helper_mixin.dart';

import 'package:soon_sak/utilities/index.dart';

class ExploreViewModel extends BaseViewModel  {
  /* Variables */
  // final Rxn<List<ExploreContent>> exploreContentList = Rxn();
  final Rxn<List<NewExploreContent>> _exploreContents = Rxn();
  final RxInt swiperIndex = 0.obs;
  final RxBool loopIsOnProgress = false.obs;

  /* Controllers */
  late final CarouselController swiperController;

  ExploreViewModel(this._exploreContentsUseCase);

  /* UseCases */
  final LoadRandomPagedExploreContentsUseCase _exploreContentsUseCase;

  /* Intents */
  // 탐색 컨텐츠 리스트 재호출
  Future<void> reFetchExploreContent() async {}

  // 검색 스크린으로 이동
  void routeToSearch() {
    Get.toNamed(AppRoutes.search);
  }

  // 컨텐츠 상세페이지로 이동
  void routeToContentDetail(ContentArgumentFormat routingArgument) {
    Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  // swiper가 이동했을 때 관련 동작
  void onSwiperChanged(int index) {
    swiperIndex(index);
  }

  Future<void> refreshContent() async {
    final response = await _exploreContentsUseCase.call();
    await response.fold(
      onSuccess: (data) async {
        _exploreContents.value = data;
        update();
      },
      onFailure: (e) {
        log('ExploreViewModel : $e');
      },
    );
  }

  Future<void> loadRandomExploreContents() async {
    final response = await _exploreContentsUseCase.call();
    response.fold(onSuccess: (data) {
      _exploreContents.value = data;
      print('========== ExploreContent 호출 성공 ${data.length}');
      update();
    }, onFailure: (e) {
      log('ExploreViewModel : $e');
    });
  }

  /* Getters */

  List<NewExploreContent>? get exploreContentList => _exploreContents.value;

  bool get isContentLoaded => _exploreContents.value.hasData;

  // refresh 버튼 노출 여부
  bool get showRefreshBtn {
    if (_exploreContents.value == null) {
      return false;
    } else if (swiperIndex.value == 19 && _exploreContents.value![19].hasData) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    swiperController = CarouselController();

    // await loadRandomExploreContents();
  }
}
