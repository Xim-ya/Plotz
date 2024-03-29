import 'dart:developer';
import 'package:soon_sak/data/repository/channel/channel_repository.dart';
import 'package:soon_sak/domain/model/content/home/newly_added_content_info.m.dart';
import 'package:soon_sak/domain/useCase/content/home/load_cached_newly_added_contents.u.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel({
    required LoadPagedCategoryCollectionUseCase
        loadPagedCategoryCollectionsUseCase,
    required LoadCachedTopPositionedContentsUseCase
        loadCachedTopPositionedContentsUseCase,
    required LoadCachedTopTenContentsUseCase loadCachedTopTenContentsUseCase,
    required LoadCachedBannerContentUseCase loadBannerContentUseCase,
    required LoadCachedNewlyAddedContentsUseCase loadNewlyAddedContentUseCase,
    required ChannelRepository channelRepository,
  })  : _loadBannerContentUseCase = loadBannerContentUseCase,
        _loadCachedTopPositionedContentsUseCase =
            loadCachedTopPositionedContentsUseCase,
        _loadCachedNewlyAddedContentsUseCase = loadNewlyAddedContentUseCase,
        _loadCachedTopTenContentsUseCase = loadCachedTopTenContentsUseCase,
        loadPagedCategoryCollectionUseCase =
            loadPagedCategoryCollectionsUseCase,
        _channelRepository = channelRepository;

  void testLocalStorageLogic() {}

  /* [Variables] */

  /// Data
  BannerModel? bannerContents; // 배너 컨텐츠
  List<TopPositionedCategory>? topPositionedCategory; // 상단 노출 콘텐츠
  NewlyAddedContentInfo? newlyAddedContentInfo; // 최근 추가된 콘텐츠
  TopTenContentsModel? topTenContents; // Top10 컨텐츠
  List<ChannelModel>? channelList; // 채널 리스트

  /// State
  int bannerContentsSliderIndex = 0; // 상단 노출 컨텐츠 슬라이더의 현재 인덱스
  BehaviorSubject<double> bannerInfoOpacity =
      BehaviorSubject<double>.seeded(1.0); // 상단 배너 정보 섹션 opacity
  // 상단 gradient box enable 여부
  bool isScrolledOnPosition = false;

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
  final LoadCachedNewlyAddedContentsUseCase
      _loadCachedNewlyAddedContentsUseCase;

  /* [Intent] */
  // Banner 슬라이더 swipe 되었을 때
  void onBannerSliderSwiped(int index) {
    bannerContentsSliderIndex = index;
    notifyListeners();
  }

  /// Banner 슬라이더가 scroll 되었을 때
  /// [Carousel의] onScrollChange 파라미터 값(double)을 fade in-out 애니메이션 효과를 설정
  void onBannerSliderScrolled(double? position) {
    if (position.hasData) {
      final integerRemoved = position!.remainder(1.0).toStringAsFixed(3);
      final remain = 1 - double.parse(integerRemoved);

      if (remain > 0.6) {
        bannerInfoOpacity.add(remain);
      } else if (remain > 0.48 && remain < 0.52) {
        bannerInfoOpacity.add(0);
      } else {
        bannerInfoOpacity.add(double.parse(integerRemoved));
      }
    }
  }

  // 컨텐츠 상세 화면으로 이동
  void routeToContentDetail(
    BuildContext context,
    ContentArgumentFormat routingArgument, {
    required String sectionType,
  }) {
    AppAnalytics.instance.logEvent(
      name: 'goToContent',
      parameters: {sectionType: routingArgument.originId},
    );

    context.push(AppRoutes.contentDetail,
        extra: {'arg1': routingArgument, 'arg2': true});
  }

  // 배너, 배너 상세 콘텐츠로 이동
  void routeToBannerContentDetail(BuildContext context) {
    final arg = ContentArgumentFormat(
      originId: selectedBannerContent!.originId,
      contentId: selectedBannerContent!.id,
      contentType: selectedBannerContent!.type,
      title: selectedBannerContent!.title,
    );
    AppAnalytics.instance.logEvent(
      name: 'goToContent',
      parameters: {'banner': arg.originId},
    );

    context.push(AppRoutes.contentDetail, extra: {'arg1': arg, 'arg2': true});
    // context
    //     .push(AppRoutes.tabs + AppRoutes.contentDetail, extra: {'arg1': arg});
  }

  // 스크롤 동작 관련 이벤트
  void _manageInteractionOnScroll() {
    // 왜 이게 난 더 직관적이지..?
    // guard let문 느낌이 나서 더 좋음
    if (scrollController.offset < 390 && isScrolledOnPosition == false) return;
    if (scrollController.offset >= 390 && isScrolledOnPosition == true) return;

    if (scrollController.offset >= 390) {
      isScrolledOnPosition = true;
      notifyListeners();
    } else {
      isScrolledOnPosition = false;
      notifyListeners();
    }
  }

  // 채널 상세 스크린으로 이동
  void routeToChannelDetail(BuildContext context,
      {required int selectedIndex}) {
    context.push(AppRoutes.channelDetail,
        extra: {'arg1': channelList![selectedIndex], 'arg2': false});
    // context.push(AppRoutes.channelDetail,
    //     extra: {'arg1': channelList![selectedIndex], 'arg2': true});
  }

  // 채널 리스트 호출
  Future<void> _fetchChannelList() async {
    final response = await _channelRepository.loadChannelsBaseOnSubscribers();
    response.fold(
      onSuccess: (data) {
        channelList = data;
        notifyListeners();
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
        topTenContents = data;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(
            message: '인기 콘텐츠를 정보를 불러오는데 실패했습니다',
            isUsedOnTabScreen: true,
            context);

        log('HomeViewModel > $e');
      },
    );
  }

  // Top10 컨텐츠 호출
  Future<void> _fetchNewlyAddedContents() async {
    final response = await _loadCachedNewlyAddedContentsUseCase.call();
    response.fold(
      onSuccess: (data) {
        newlyAddedContentInfo = data;
        notifyListeners();
        print("최근 업로드 된 콘텐츠 호출 성공");
      },
      onFailure: (e) {
        AlertWidget.newToast(
            message: '최근 업로드된 콘텐츠를 불러오는데 실패했습니다',
            isUsedOnTabScreen: true,
            context);

        log('HomeViewModel > $e');
      },
    );
  }

  // 배너 컨텐츠 호출
  Future<void> _fetchBannerContents() async {
    final response = await _loadBannerContentUseCase.call();
    response.fold(
      onSuccess: (data) {
        bannerContents = data;
        notifyListeners();
      },
      onFailure: (e) {
        AlertWidget.newToast(
            message: '배너 콘텐츠 정보를 불러오는데 실패했습니다',
            isUsedOnTabScreen: true,
            context);
        _loadBannerContentUseCase.deleteLocalData();
        log('HomeViewModel > $e');
      },
    );
  }

  // 상단 노출 카테고리 컬렉션 호출
  Future<void> _fetchTopPositionedCollection() async {
    final response = await _loadCachedTopPositionedContentsUseCase.call();
    response.fold(onSuccess: (data) {
      topPositionedCategory = data;
      notifyListeners();
    }, onFailure: (e) {
      AlertWidget.newToast(
          message: '일부 콘텐츠를 불러오는데 실패했습니다', isUsedOnTabScreen: true, context);
      _loadCachedTopPositionedContentsUseCase.deleteLocalStorageField();
      log('HomeViewModel > $e');
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    unawaited(AppAnalytics.instance.setCurrentScreen(screenName: '/home'));

    scrollController = ScrollController();

    /// NOTE : api call 호출 메소드 순서에 주의
    /// 어떤 이유에서 pagingController [initUseCase] 메소드가
    /// [Future.wait] 동작 후에 실행이 안됨
    /// 선 호출 할 수 있도록 함.
    /// TODO: 이후에 원인을 파학하고 수정
    loadPagedCategoryCollectionUseCase.initUseCase();

    // scrollController = ScrollController();
    scrollController.addListener(_manageInteractionOnScroll);

    carouselController = CarouselController();

    // 병렬 호출
    await Future.wait([
      _fetchNewlyAddedContents(),
      _fetchBannerContents(),
      _fetchTopPositionedCollection(),
      _fetchTopTenContents(),
      _fetchChannelList(),
    ]);
  }

  @override
  void onDispose() {
    bannerInfoOpacity.close();
  }
}
