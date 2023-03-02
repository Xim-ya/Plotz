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
  /// swiper Index 값을 기준으로 컨텐츠 데이터를 추가 호출
  /// 호출 시점 : 총 컨텐츠 길이 - 4
  /// 더 이상 호출할 메세지가 없을 경우
  /// 유저에게 toast 메세지를 띄움 (마지막 컨텐츠에서)
  void onSwiperChanged(int index) {
    swiperIndex(index);
    final exploreContentsLength = _exploreContents.value!.length - 1;
    if (index + 4 == exploreContentsLength) {
      loadMoreContents(index);
    }

    if (index == exploreContentsLength && alreadyShowedToast.isFalse) {
      unawaited(
          AlertWidget.animatedToast('마지막 컨텐츠 입니다', isUsedOnTabScreen: true));
      alreadyShowedToast(true); // 더 이상 토스트 메세를 노출하지 않음.
    }
  }

  /// 컨텐츠 데이터 추가 호출
  Future<void> loadMoreContents(int swiperIndex) async {
    if (_exploreContentsUseCase.moreCallIsAllowed.isTrue) {
      final response = await _exploreContentsUseCase.loadMoreContents();
      await response.fold(
        onSuccess: (data) async {
          _exploreContents.value?.addAll(data);
          update();
        },
        onFailure: (e) {
          AlertWidget.animatedToast(
            '데이터를 불러오지 못했습니다',
            isUsedOnTabScreen: true,
          );
          log('ExploreViewModel : $e');
        },
      );
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
      AlertWidget.animatedToast(
        '데이터를 불러오지 못했습니다',
        isUsedOnTabScreen: true,
      );
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
