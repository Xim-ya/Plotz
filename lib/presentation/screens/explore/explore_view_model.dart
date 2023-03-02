import 'dart:developer';

import 'package:soon_sak/utilities/extensions/tab_loading_state_extension.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  final Rxn<List<ExploreContent>> _exploreContents = Rxn();
  final RxInt swiperIndex = 0.obs;
  final RxBool loopIsOnProgress = false.obs;
  final RxBool alreadyShowedToast = false.obs;
  TabLoadingState loadingState = TabLoadingState.initState;

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

  /// swiper가 이동했을 때 관련 동작
  /// swiper Index 값을 통해 컨텐츠 데이터를 추가 호출
  void onSwiperChanged(int index) {
    swiperIndex(index);
    final exploreContentsLength = _exploreContents.value!.length - 1;
    if (index == exploreContentsLength) {
      loadMoreContents();
    }
  }

  /// 컨텐츠 데이터 추가 호출
  /// 추가할 데이터가 존재할 경우에만 호출을 진행함
  /// 더 이상 호출 데이터가 없을 경우 'toast' 메세지를 띄움
  Future<void> loadMoreContents() async {
    if (_exploreContentsUseCase.moreCallIsAllowed.isTrue) {
      final response = await _exploreContentsUseCase.loadMoreContents();
      await response.fold(
        onSuccess: (data) async {
          _exploreContents.value?.addAll(data);
          update();
        },
        onFailure: (e) {
          log('ExploreViewModel : $e');
        },
      );
    } else {
      if (alreadyShowedToast.isFalse) {
        unawaited(
            AlertWidget.animatedToast('마지막 컨텐츠 입니다', isUsedOnTabScreen: true));
        alreadyShowedToast(true); // 더 이상 토스트 메세를 노출하지 않음.
      }
    }
  }

  /// 컨텐츠 데이터를 호출 (20개)
  /// 랜덤하게 컨텐츠를 가져오며
  /// 해당 메소드는 한번만 실행됨
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

  List<ExploreContent>? get exploreContentList => _exploreContents.value;

  bool get isContentLoaded =>
      _exploreContents.value.hasData && loadingState.isDone;

  Future<void> prepare() async {
    loadingState = TabLoadingState.loading;
    await loadRandomExploreContents();
    loadingState = TabLoadingState.done;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    swiperController = CarouselController();
  }
}
