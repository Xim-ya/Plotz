import 'dart:async';
import 'dart:developer';
import 'package:soon_sak/domain/useCase/content/home/load_paged_category_collection_use_case.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:http/http.dart' as http;

part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    this.loadPagedCategoryCollectionUseCase,
    this._loadCachedTopTenContentsUseCase,
    this._loadBannerContentUseCase,
  );

  /* [Variables] */

  /// Data
  final Rxn<BannerModel> _bannerContent = Rxn(); // 배너 컨텐츠
  final Rxn<TopTenContentsModel> _topTenContents = Rxn(); // Top10 컨텐츠

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

  PagingController<int, CategoryContentSection> get pagingController =>
      loadPagedCategoryCollectionUseCase.pagingController;

  /* [UseCase] */
  final LoadPagedCategoryCollectionUseCase loadPagedCategoryCollectionUseCase;
  final LoadCachedBannerContentUseCase _loadBannerContentUseCase;
  final LoadCachedTopTenContentsUseCase _loadCachedTopTenContentsUseCase;

  /* [Intent] */
  // Banner 슬라이더 swipe 되었을 때
  void onBannerSliderSwiped(int index) {
    topExposedContentSliderIndex.value = index;
  }

  // 컨텐츠 상세 화면으로 이동
  void routeToContentDetail(ContentArgumentFormat routingArgument,
      {required String sectionType}) {
    AppAnalytics.instance.logEvent(
        name: 'goToContent',
        parameters: {sectionType: routingArgument.originId});

    Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  void fetchNewCollectionPage() {
    loadPagedCategoryCollectionUseCase.call();
    update();
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

  // Top10 컨텐츠 호출
  Future<void> _fetchTopTenContents() async {
    final response = await _loadCachedTopTenContentsUseCase.call();
    response.fold(onSuccess: (data) {
      _topTenContents.value = data;
      update();
    }, onFailure: (e) {
      log('HomeViewModel > $e');
    });
  }

  // 배너 컨텐츠 호출
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
  void onReady() {
     loadPagedCategoryCollectionUseCase.initUseCase();
    super.onReady();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    /// NOTE : api call 호출 메소드 순서에 주의
    /// 어떤 이유에서 pagingController [initUseCase] 메소드가
    /// [Future.wait] 동작 후에 실행이 안됨
    /// 선 호출 할 수 있도록 함.
    /// TODO: 이후에 원인을 파학하고 수정
    loadPagedCategoryCollectionUseCase.initUseCase();

    unawaited(AppAnalytics.instance.setCurrentScreen(screenName: '/home'));
    loading(true);

    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      turnOnBlurInAppBar();
    });

    carouselController = CarouselController();


    // 병렬 호출
    await Future.wait([
      _fetchBannerContents(),
      _fetchTopTenContents(),
    ]);


  }
}
