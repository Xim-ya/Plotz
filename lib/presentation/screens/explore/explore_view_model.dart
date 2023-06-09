import 'dart:developer';

import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/utilities/extensions/tab_loading_state_extension.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreViewModel extends BaseViewModel {
  /* Variables */
  final BehaviorSubject<List<ExploreContent>> exploreContents;
  int swiperIndex = 0;
  bool loopIsOnProgress = false;
  bool alreadyShowedToast = false;

  /* Controllers */
  late final CarouselController swiperController;

  ExploreViewModel({
    required LoadRandomPagedExploreContentsUseCase exploreContentsUseCase,
  })  : _exploreContentsUseCase = exploreContentsUseCase,
        exploreContents = BehaviorSubject<List<ExploreContent>>();

  /* UseCases */
  final LoadRandomPagedExploreContentsUseCase _exploreContentsUseCase;

  /* Intents */
  // 탐색 컨텐츠 리스트 재호출
  Future<void> reFetchExploreContent() async {}

  // 검색 스크린으로 이동
  void routeToSearch() {
    context.push(AppRoutes.tabs + AppRoutes.search);
  }

  // 컨텐츠 상세페이지로 이동
  void routeToContentDetail(int routingArgument) {
    final contentItem = exploreContentList[routingArgument];
    AppAnalytics.instance.logEvent(
      name: 'goToContent',
      parameters: {'explore': contentItem.originId},
    );

    final arg = ContentArgumentFormat(
      contentId: SplittedIdAndType.fromOriginId(contentItem.originId).id,
      contentType: SplittedIdAndType.fromOriginId(contentItem.originId).type,
      posterImgUrl: contentItem.posterImgUrl,
      title: contentItem.title,
      originId: contentItem.originId,
      channelName: contentItem.channelName,
      channelLogoImgUrl: contentItem.channelLogoImgUrl,
      subscribersCount: contentItem.subscribersCount,
    );
    context.push(AppRoutes.contentDetail, extra: {'arg1': arg, 'arg2': true});
  }

  /// swiper가 이동했을 때 관련 동작
  /// swiper Index 값을 기준으로 컨텐츠 데이터를 추가 호출
  /// 호출 시점 : 총 컨텐츠 길이 - 4
  /// 더 이상 호출할 메세지가 없을 경우
  /// 유저에게 toast 메세지를 띄움 (마지막 컨텐츠에서)
  void onSwiperChanged(int index) {
    swiperIndex = index;
    final exploreContentsLength = exploreContents.value.length - 1;
    if (index + 4 == exploreContentsLength) {
      loadMoreContents(index);
    }

    if (index == exploreContentsLength && alreadyShowedToast == false) {
      unawaited(
        AlertWidget.newToast(
            message: '마지막 콘텐츠 입니다', isUsedOnTabScreen: true, context),
      );
      alreadyShowedToast = true; // 더 이상 토스트 메세를 노출하지 않음.
    }
  }

  /// 컨텐츠 데이터 추가 호출
  Future<void> loadMoreContents(int swiperIndex) async {
    if (_exploreContentsUseCase.moreCallIsAllowed == true) {
      final response = await _exploreContentsUseCase.loadMoreContents();
      await response.fold(
        onSuccess: (data) async {
          exploreContents.add(data);
        },
        onFailure: (e) {
          AlertWidget.newToast(
            message: '데이터를 불러오지 못했습니다',
            isUsedOnTabScreen: true,
            context,
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
    response.fold(
      onSuccess: (data) {
        exploreContents.add(data);
        print('========== ExploreContent 호출 성공 ${data.length}');
      },
      onFailure: (e) {
        AlertWidget.newToast(
          message: '데이터를 불러오지 못했습니다',
          isUsedOnTabScreen: true,
          context,
        );
        log('ExploreViewModel : $e');
      },
    );
  }

  /* Getters */

  List<ExploreContent> get exploreContentList => exploreContents.value;

  bool get isContentLoaded => exploreContents.hasData && loadingState.isDone;

  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;
    DateTime startTime = DateTime.now();
    await loadRandomExploreContents();
    // 메소드 실행이 완료된 후의 시간을 종료 시간으로 기록
    DateTime endTime = DateTime.now();

    // 두 시간의 차이를 계산
    Duration elapsedTime = endTime.difference(startTime);

    // 실행 시간 출력
    print('Explore 비동기 메소드 실행 시간: ${elapsedTime.inMilliseconds} 초');
    loadingState = ViewModelLoadingState.done;
  }

  @override
  Future<void> onInit() async {
    super.onInit();

    swiperController = CarouselController();
  }
}
