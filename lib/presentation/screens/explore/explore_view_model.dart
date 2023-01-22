import 'package:uppercut_fantube/domain/useCase/explore/partial_load_content_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/explore/test_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  final Rxn<List<ExploreContent>> exploreContentList = Rxn();
  final RxInt swiperIndex = 0.obs;

  /* Controllers */
  late final CarouselController swiperController;

  ExploreViewModel(this._partialLoadContentUseCase, this._testUseCase);

  /* UseCases */
  final PartialLoadContentUseCase _partialLoadContentUseCase;
  final TestUseCase _testUseCase;

  /* Intents */
  // 탐색 컨텐츠 리스트 호출
  Future<void> _fetchExploreContent() async {
    final responseResult = await _partialLoadContentUseCase.loadContentIdList();
    exploreContentList.value = responseResult;
  }

  // 탐색 컨텐츠 리스트 재호출
  Future<void> reFetchExploreContent() async {
    // 슬라이더 State 및 데이터 초기화
    _partialLoadContentUseCase.isCanceled(true);
    _partialLoadContentUseCase.maxScannedIndex(0);
    exploreContentList.value = null;
    swiperIndex(0);
    await swiperController.animateToPage(0);

    // 탐색 컨텐츠 재호출
    final responseResult = await _partialLoadContentUseCase.loadContentIdList();
    exploreContentList.value = responseResult;
    exploreContentList.value?.shuffle();

    // 컨텐츠 리스트 내부 필드값 업데이트
    await _partialLoadContentUseCase.changeCanceledState();
    await _partialLoadContentUseCase.updateExploreContentFields(0);
  }

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
    swiperIndex(index);
    updateContentListInfo();
    // if (index + 1 == exploreContentList.value?.length) {
    //   AlertWidget.toast('새로운 컨텐츠를 불러옵니다');
    //   reFetchExploreContent();
    // }
  }

  @override
  void onInit() {
    super.onInit();

    swiperController = CarouselController();

    _fetchExploreContent().then((value) {
      updateContentListInfo();
    });
    _testUseCase.testLoop();
  }
}
