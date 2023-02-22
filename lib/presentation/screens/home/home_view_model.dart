
import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';
import 'package:http/http.dart' as http;
part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel {

  HomeViewModel(
    this._loadCachedCategoryContentCollectionUseCase,
    this._loadCachedTopTenContentsUseCase,
    this._loadBannerContentUseCase,
  );

  /* [Variables] */

  /// Data
  final Rxn<BannerModel> _bannerContent = Rxn();
  final Rxn<TopTenContentsModel> _topTenContents = Rxn();
  final Rxn<CategoryContentCollection> _categoryContentCollection = Rxn();

  // final Rxn<List<CategoryBaseContentList>> contentListWithCategories =
  //     Rxn(); // 카테고리 및 카테고리 컨텐츠

  /// State
  late double scrollOffset = 0;
  final RxBool showAppbarBackground = true.obs;
  RxBool showBlurAtAppBar = false.obs;
  RxInt topExposedContentSliderIndex = 0.obs; // 상단 노출 컨텐츠 슬라이더의 현재 인덱스

  /// Size
  final double appBarHeight = SizeConfig.to.statusBarHeight + 56;

  ///  Controllers
  late ScrollController scrollController;
  late CarouselController carouselController;

  /* [UseCase] */
  final LoadCachedBannerContentUseCase _loadBannerContentUseCase;
  final LoadCachedTopTenContentsUseCase _loadCachedTopTenContentsUseCase;
  final LoadCachedCategoryContentCollectionUseCase
      _loadCachedCategoryContentCollectionUseCase;

  /* [Intent] */
  // Banner 슬라이더 swipe 되었을 때
  void onBannerSliderSwiped(int index) {
    topExposedContentSliderIndex.value = index;
  }

  // 컨텐츠 상세 화면으로 이동
  void routeToContentDetail(ContentArgumentFormat routingArgument) {
      Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  // 카테고리 컨텐츠 collection 정보 호출
  Future<void> _fetchCategoryContentCollection() async {
    final response = await _loadCachedCategoryContentCollectionUseCase.call();
    response.fold(
      onSuccess: (data) {
        _categoryContentCollection.value = data;
      },
      onFailure: (e) {
        log('HomeViewModel : $e');
      },
    );
  }

  /// UI Intent Method
  // AppBar Blur효과 avtivate 여부
  void turnOnBlurInAppBar() {
    // Status Bar Height 보다 offest이 작을 땐 Blur 처리 X
    if (scrollOffset <= SizeConfig.to.statusBarHeight) {
      showBlurAtAppBar(false);
      return;
    } else {
      /** 중복 할당을 방지하기 위해. 조건 두가지를 추가.
       * [scrollController.position.userScrollDirection] 유저가 아래로 스크롤하고
       * [showBlurAtAppBar.isTrue] blur값이 true로 선언되어 있다면 값을 변경.
       * */
      if (scrollController.position.userScrollDirection ==
              ScrollDirection.forward &&
          showBlurAtAppBar.isTrue) {
        showBlurAtAppBar(false);
        return;
      } else if (scrollController.position.userScrollDirection ==
              ScrollDirection.reverse &&
          showBlurAtAppBar.isFalse) {
        showBlurAtAppBar(true);
        return;
      }
    }
  }

  // 검색 스크린으로 이동
  void routeToSearch() {
    Get.toNamed(AppRoutes.search);
  }

  Future<void> _fetchTopTenContents() async {
    final response = await _loadCachedTopTenContentsUseCase.call();
    response.fold(onSuccess: (data) {
      _topTenContents.value = data;
      update();
    }, onFailure: (e) {
      log('HomeViewModel > $e');
    });
  }

  Future<void> _fetchBannerContents() async {
    final response = await _loadBannerContentUseCase.call();
    response.fold(
      onSuccess: (data) {
        _bannerContent.value = data;
        update();
      },
      onFailure: (e) {
        log('HomeViewModel > $e');
      },
    );
  }


  @override
  Future<void> onInit() async {
    super.onInit();
    loading(true);

    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      turnOnBlurInAppBar();
    });

    carouselController = CarouselController();

    await Future.wait([
      _fetchBannerContents(),
      _fetchTopTenContents(),
      _fetchCategoryContentCollection()
    ]);
    update();
  }
}
