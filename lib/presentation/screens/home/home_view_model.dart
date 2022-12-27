import 'dart:developer';
import 'package:uppercut_fantube/utilities/index.dart';

part 'home_view_model.part.dart';

class HomeViewModel extends BaseViewModel {
  /// 임시
  final ContentDataSource _dataSource;

  HomeViewModel(
    this._dataSource,
    this._loadTopExposedContentList,
  );

  /* [Variables] */

  /// Data
  final Rxn<List<PosterExposureContent>> _topExposedContentList =
      Rxn(); // 상단 노출 컨텐츠
  final Rxn<List<PosterExposureContent>> topTenContentList =
      Rxn(); // Top 10 컨텐츠
  final Rxn<List<CategoryBaseContentList>> contentListWithCategories =
      Rxn(); // 카테고리 및 카테고리 컨텐츠

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
  final LoadTopExposedContentListUseCase _loadTopExposedContentList;

  /* [Intent] */

  void resetContentList(int id) {
    print(_topExposedContentList.value!.length);
    _topExposedContentList.value!
        .removeWhere((element) => element.contentId == id);
    update();
    carouselController.animateToPage(_topExposedContentList.value!
        .indexWhere((element) => element.contentId == id));
    print(_topExposedContentList.value!.length);
    print(topExposedContentList!.length);
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

  // 상단 노출 컨텐츠 리스트 호출
  Future<void> _fetchTopExposedContentList() async {
    final responseResult = await _loadTopExposedContentList.call();
    responseResult.fold(onSuccess: (data) {
      _topExposedContentList.value = data;
    }, onFailure: (e) {
      log(e.toString());
    });
  }

  // Top10 컨텐츠 리스트 호출
  Future<void> _fetchTopTenContentList() async {
    // final responseResult = await _loadTopTenContentListUseCase();
    final responseResult = await ContentRepository.to.loadTopTenContentList();
    responseResult.fold(
      onSuccess: (data) {
        topTenContentList.value = data;
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  // 카테고리 & 해당 카테고리 컨텐츠 리스트 호출
  Future<void> _fetchContentListOfCategory() async {
    final responseResult =
        await ContentRepository.to.loadContentListWithCategory();
    responseResult.fold(onSuccess: (data) {
      contentListWithCategories.value = data;
    }, onFailure: (e) {
      AlertWidget.toast('카테고리 정보를 불러들이는데 실패하였습니다');
      log(e.toString());
    });
  }

  void launchAnotherApp() async {
    if (!await launchUrl(
        Uri.parse('https://www.youtube.com/watch?v=zhdbtAqne_I&t=1162s'),
        mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ';
    }
  }

  /// Routes Method
  void routeToContentDetail(ContentArgumentFormat routingArgument) {
    Get.toNamed(AppRoutes.contentDetail, arguments: routingArgument);
  }

  /// Youtube Video Comment
  Future<void> youtubeIntent() async {
    // 유튜브 댓글
    final video = await YoutubeMetaData.yt.videos.get('9XdAsuXthXA');
    // final video = await YoutubeMetaData.yt.channels.get(id);
    // final commentList =
    //     await YoutubeMetaData.yt.videos.commentsClient.getComments(video);
    final videoInfo = video.thumbnails.highResUrl;

    // final commentList =
    // await YoutubeMetaData.yt.videos.commentsClient.getComments(video);
  }

  /// Mock Json Data Video
  Future<void> getJsonMockData() async {
    final responseResult = await _dataSource.loadTopExposedContentList();
    final List<PosterExposureContent> mockItemLis = responseResult;
  }

  @override
  void onInit() {
    super.onInit();

    scrollController = ScrollController();
    scrollController.addListener(() {
      scrollOffset = scrollController.offset;
      turnOnBlurInAppBar();
    });

    carouselController = CarouselController();

    _fetchTopTenContentList();
    _fetchTopExposedContentList();
    // _fetchContentListOfCategory();

    youtubeIntent();
  }
}
