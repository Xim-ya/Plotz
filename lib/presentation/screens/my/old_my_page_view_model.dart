import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/utilities/index.dart';

class OldMyPageViewModel extends BaseViewModel {
  OldMyPageViewModel(
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



  /// 유저 시청 기록 추가
  Future<void> updateUserWatchHistory(
    UserWatchHistoryItem selectedContent,
  ) async {
    final requestData = WatchingHistoryRequest(
      userId: _userService.userInfo.value.id!,
      originId: selectedContent.originId,
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
