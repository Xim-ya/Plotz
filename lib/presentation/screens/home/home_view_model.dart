import 'dart:developer';
import 'package:soon_sak/data/repository/channel/channel_respoitory.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';
import 'package:soon_sak/domain/model/content/home/top_positioned_collection.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_top_positioned_content_use_case.dart';
import 'package:soon_sak/utilities/index.dart';

part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(
    this.loadPagedCategoryCollectionUseCase,
    this._loadCachedTopPositionedContentsUseCase,
    this._loadCachedTopTenContentsUseCase,
    this._loadBannerContentUseCase,
    this._channelRepository,
  );

  /* [Variables] */

  /// Data
  final Rxn<BannerModel> _bannerContents = Rxn(); // 배너 컨텐츠
  final Rxn<List<TopPositionedCategory>> topPositionedCategory =
      Rxn(); // 상단 노출 콜렉션(카테고리)
  final Rxn<TopTenContentsModel> _topTenContents = Rxn(); // Top10 컨텐츠
  final Rxn<List<ChannelModel>> _channelList = Rxn(); // 채널 리스트

  /// State
  final RxInt bannerContentsSliderIndex = 0.obs; // 상단 노출 컨텐츠 슬라이더의 현재 인덱스
  final RxDouble bannerInfoOpacity = 1.0.obs; // 상단 배너 정보 섹션 opacity
  // 상단 gradient box enable 여부
  final RxBool isScrolledOnPosition = false.obs;

  /* [Controllers] */
  late ScrollController scrollController;
  late CarouselController carouselController;

  PagingController<int, CategoryContentSection> get pagingController =>
      loadPagedCategoryCollectionUseCase.pagingController;

  /* [Repository] */
  final ChannelRepository _channelRepository;

  /* [UseCase] */
  final LoadPagedCategoryCollectionUseCase loadPagedCategoryCollectionUseCase;
  final LoadCachedBannerContentUseCase _loadBannerContentUseCase;
  final LoadCachedTopTenContentsUseCase _loadCachedTopTenContentsUseCase;
  final LoadCachedTopPositionedContentsUseCase
      _loadCachedTopPositionedContentsUseCase;

  /* [Intent] */
  // Banner 슬라이더 swipe 되었을 때
  void onBannerSliderSwiped(int index) {
    bannerContentsSliderIndex.value = index;
  }

  /// Banner 슬라이더가 scroll 되었을 때
  /// [Carousel의] onScrollChange 파라미터 값(double)을 fade in-out 애니메이션 효과를 설정
  void onBannerSliderScrolled(double? position) {
    if (position.hasData) {
      final integerRemoved = position!.remainder(1.0).toStringAsFixed(3);
      final remain = 1 - double.parse(integerRemoved);

      if (remain > 0.6) {
        bannerInfoOpacity(remain);
      } else if (remain > 0.48 && remain < 0.52) {
        bannerInfoOpacity(0);
      } else {
        bannerInfoOpacity(double.parse(integerRemoved));
      }
    }
  }

  // 컨텐츠 상세 화면으로 이동
  void routeToContentDetail(
    ContentArgumentFormat routingArgument, {
    required String sectionType,
  }) {
    AppAnalytics.instance.logEvent(
      name: 'goToContent',
      parameters: {sectionType: routingArgument.originId},
    );

    Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  // 스크롤 동작 관련 이벤트
  void _manageInteractionOnScroll() {
    // 왜 이게 난 더 직관적이지..?
    // guard let문 느낌이 나서 더 좋음
    if (scrollController.offset < 390 && isScrolledOnPosition.isFalse) return;
    if (scrollController.offset >= 390 && isScrolledOnPosition.isTrue) return;

    if (scrollController.offset >= 390) {
      isScrolledOnPosition(true);
    } else {
      isScrolledOnPosition(false);
    }
  }

  // 검색 스크린으로 이동
  void routeToSearch() {
    Get.toNamed(AppRoutes.search);
  }

  // 채널 상세 스크린으로 이동
  void routeToChannelDetail(ChannelModel channel) {
    Get.toNamed(AppRoutes.home + AppRoutes.channelDetail, arguments: channel);
  }

  // 채널 리스트 호출
  Future<void> _fetchChannelList() async {
    final response = await _channelRepository.loadChannelsBaseOnSubscribers();
    response.fold(
      onSuccess: (data) {
        _channelList.value = data;
      },
      onFailure: (e) {
        log('HomeViewModel : 채널 리스트 호출 실패');
      },
    );
  }

  // Top10 컨텐츠 호출
  Future<void> _fetchTopTenContents() async {
    final response = await _loadCachedTopTenContentsUseCase.call();
    response.fold(
      onSuccess: (data) {
        _topTenContents.value = data;
      },
      onFailure: (e) {
        AlertWidget.animatedToast('인기 콘텐츠를 정보를 불러오는데 실패했습니다',
            isUsedOnTabScreen: true);

        log('HomeViewModel > $e');
      },
    );
  }

  // 배너 컨텐츠 호출
  Future<void> _fetchBannerContents() async {
    final response = await _loadBannerContentUseCase.call();
    response.fold(
      onSuccess: (data) {
        _bannerContents.value = data;
      },
      onFailure: (e) {
        AlertWidget.animatedToast('배너 콘텐츠 정보를 불러오는데 실패했습니다',
            isUsedOnTabScreen: true);
        _loadBannerContentUseCase.deleteLocalData();
        log('HomeViewModel > $e');
      },
    );
  }

  // 상단 노출 카테고리 컬렉션 호출
  Future<void> _fetchTopPositionedCollection() async {
    final response = await _loadCachedTopPositionedContentsUseCase.call();
    response.fold(onSuccess: (data) {
      topPositionedCategory.value = data;
    }, onFailure: (e) {
      AlertWidget.animatedToast('일부 콘텐츠를 불러오는데 실패했습니다',
          isUsedOnTabScreen: true);
      _loadCachedTopPositionedContentsUseCase.deleteLocalStorageField();
      log('HomeViewModel > $e');
    });
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    unawaited(AppAnalytics.instance.setCurrentScreen(screenName: '/home'));

    /// NOTE : api call 호출 메소드 순서에 주의
    /// 어떤 이유에서 pagingController [initUseCase] 메소드가
    /// [Future.wait] 동작 후에 실행이 안됨
    /// 선 호출 할 수 있도록 함.
    /// TODO: 이후에 원인을 파학하고 수정
    loadPagedCategoryCollectionUseCase.initUseCase();

    scrollController = ScrollController();
    scrollController.addListener(() {
      _manageInteractionOnScroll();
    });

    carouselController = CarouselController();

    // 병렬 호출
    await Future.wait([
      _fetchBannerContents(),
      _fetchTopPositionedCollection(),
      _fetchTopTenContents(),
      _fetchChannelList(),
    ]);
  }
}
