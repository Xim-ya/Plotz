import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  // final Rxn<List<ExploreContent>> exploreContentList = Rxn();
  final Rxn<ExploreContentModel> _exploreContentModel = Rxn();
  final RxInt swiperIndex = 0.obs;
  final RxBool loopIsOnProgress = false.obs;

  /* Controllers */
  late final CarouselController swiperController;

  ExploreViewModel(
      this._partialLoadContentUseCase, this._exploreContentsUseCase);

  /* UseCases */
  final PartialLoadContentUseCase _partialLoadContentUseCase;
  final LoadRandomPagedExploreContentsUseCase _exploreContentsUseCase;

  /* Intents */
  // 탐색 컨텐츠 리스트 재호출
  Future<void> reFetchExploreContent() async {}

  // 컨텐츠 리스트 내부 필드값 업데이트
  void updateContentListInfo() {
    _partialLoadContentUseCase.updateExploreContentFields(swiperIndex.value);
  }

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
    // if (index == 6 && _exploreContentsUseCase.pagedAllowed == true) {
    //   loadMoreContents();
    // }
  }

  void test() {
    print('${exploreContentModel?.contents.length}');
  }

  Future<void> loadMoreContents() async {
    final response = await _exploreContentsUseCase.pagedCall();
    await response.fold(
      onSuccess: (data) async {
        _exploreContentModel.value!.contents.addAll(data.contents);
        update();
        await data.updateYoutubeChannelInfo();
      },
      onFailure: (e) {
        log('ExploreViewModel : $e');
      },
    );
  }

  Future<void> loadRandomExploreContents() async {
    final response = await _exploreContentsUseCase.call();
    response.fold(onSuccess: (data) {
      _exploreContentModel.value = data;
      update();
      data.updateYoutubeChannelInfo();
    }, onFailure: (e) {
      log('ExploreViewModel : $e');
    });
  }

  ExploreContentModel? get exploreContentModel => _exploreContentModel.value;

  bool get isContentLoaded => _exploreContentModel.value.hasData;

  List<ExploreContentItem>? get exploreContents =>
      _exploreContentModel.value?.contents;

  @override
  Future<void> onInit() async {
    super.onInit();

    swiperController = CarouselController();
    await loadRandomExploreContents();
  }
}
