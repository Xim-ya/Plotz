import 'package:uppercut_fantube/domain/useCase/content/explore/load_explore_content_by_slider_index_use_case.dart';
import 'package:uppercut_fantube/domain/useCase/explore/partial_load_content_use_case.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  final Rxn<List<ExploreContent>> exploreContentList = Rxn();
  final RxInt swiperIndex = 0.obs;

  /* Controllers */
  late final CarouselController swiperController;

  ExploreViewModel(this._partialLoadContentUseCase);

  /* UseCases */
  PartialLoadContentUseCase _partialLoadContentUseCase;

  /* Intents */
  // 탐색 컨텐츠 리스트 호출
  Future<void> _fetchExploreContent() async {
    final responseResult = await _partialLoadContentUseCase.loadContentIdList();
    exploreContentList.value = responseResult;
  }

  // 탐색 컨텐츠 리스트 재호출
  Future<void> reFetchExploreContent() async {
    // 슬라이더 State 및 데이터 초기화
    _partialLoadContentUseCase.cancelFuture();
    _partialLoadContentUseCase.maxScannedIndex.value = 0;
    exploreContentList.value = null;
    swiperIndex(0);
    await swiperController.animateToPage(0);

    // 탐색 컨텐츠 재호출
    print("aim");
    final responseResult = await _partialLoadContentUseCase.loadContentIdList();
    exploreContentList.value = responseResult;
    exploreContentList.value?.shuffle();

    // 컨텐츠 리스트 내부 필드값 업데이트
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

  @override
  void onInit() {
    super.onInit();

    swiperController = CarouselController();

    _fetchExploreContent().then((value) {
      updateContentListInfo();
    });
  }
}
