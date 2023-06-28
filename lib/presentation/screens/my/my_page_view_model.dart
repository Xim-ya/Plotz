import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageViewModel extends BaseViewModel {
  MyPageViewModel(
      {required UserRepository userRepository,
      required UserService userService})
      : _userService = userService,
        _userRepository = userRepository;

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Variables */
  UserCurationSummary? curationSummary; //  큐레이션 내역 요약 정보
  BehaviorSubject<List<UserWatchHistoryItem>> get watchHistorySub =>
      _userService.userWatchHistory;

  BehaviorSubject<UserModel> get userInfoSub => _userService.userInfo;

  /* Intents */
  // 설정 스크린으로 이동
  void routeToSetting(BuildContext context) {
    context.push(AppRoutes.tabs + AppRoutes.setting);
  }

  // youtubeApp 실행
  Future<void> launchYoutubeApp(
    UserWatchHistoryItem? selectedContent,
    int index,
  ) async {
    if (selectedContent?.videoId == null) {
      return AlertWidget.newToast(
          message: '잠시만 기다려주세요. 데이터를 불러오고 있습니다.', context);
    }
    try {
      await launchUrl(
        Uri.parse(
          'https://www.youtube.com/watch?v=${selectedContent!.videoId}',
        ),
        mode: LaunchMode.externalApplication,
      );
      unawaited(
        AppAnalytics.instance.logEvent(
          name: 'playContent',
          parameters: {
            'myPage': selectedContent.originId,
          },
        ),
      );
    } catch (e) {
      await AlertWidget.newToast(message: '비디오 정보를 불러오지 못했습니디', context);
      throw '유튜브 앱(웹) 런치 실패';
    }

    /// 시청기록 업데이트
    /// 가장 최신 시청 기록의 컨텐츠를 선택했을 경우 업데이트 할 필요가 없음. (메소드 종료)
    if (index == 0) return;
    await updateUserWatchHistory(selectedContent);
  }

  /// 유저 시청 기록 추가
  Future<void> updateUserWatchHistory(
    UserWatchHistoryItem selectedContent,
  ) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value.id!,
      originId: selectedContent.originId,
      videoId: selectedContent.videoId,
    );

    final response = await _userRepository.addUserWatchHistory(requestData);
    response.fold(
      onSuccess: (_) {
        log('유저 시청기록 추가 성공');
        // 유저 시청 기록 업데이트
        _userService.updateUserWatchHistory();
        notifyListeners();
      },
      onFailure: (e) {
        log('ContentDetailViewModel : $e');
      },
    );
  }

  // 유저 시청 기록 호출
  Future<void> _fetchUserWatchHistory() async {
    await _userService.updateUserWatchHistory();
  }

  // 큐레이팅 내역 스크린으로 라우팅
  void routeToCurationHistory(BuildContext context) {
    context.push(AppRoutes.tabs + AppRoutes.curationHistory);
  }

  // 유저 큐레이션 내역 요약 정보 호출
  Future<void> fetchUserCurationSummary() async {
    final response = await _userRepository.loadUserCurationSummary();
    response.fold(
      onSuccess: (data) {
        curationSummary = data;
        notifyListeners();
      },
      onFailure: (e) {
        log('MyPageViewModel $e');
      },
    );
  }

  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;
    await fetchUserCurationSummary();
    await _fetchUserWatchHistory();
    loadingState = ViewModelLoadingState.done;
  }

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
