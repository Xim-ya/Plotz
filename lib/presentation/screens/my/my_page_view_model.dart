import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/domain/enum/setting_menu_enum.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/my_page_view_model_menu_event.part.dart'; // 메뉴 선택 이벤트

class MyPageViewModel extends BaseViewModel {
  MyPageViewModel({
    required UserRepository userRepository,
    required UserService userService,
    required SignOutUseCase signOutHandlerUseCase,
  })  : _userService = userService,
        _userRepository = userRepository,
        _signOutHandlerUseCase = signOutHandlerUseCase;

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository; 

  /* Variables */
  List<SettingMenu> settingOptions = [
    SettingMenu.feedbackAndCs,
    SettingMenu.termsAndPolicy,
    SettingMenu.logOut,
    SettingMenu.withdrawal,
  ];

  bool hideGradient = true; // 앱바 배경색 노출 여부
  UserCurationSummary? curationSummary; //  큐레이션 내역 요약 정보
  BehaviorSubject<List<UserWatchHistoryItem>> get watchHistorySub =>
      _userService.userWatchHistory;

  /* UseCase*/
  final SignOutUseCase _signOutHandlerUseCase;

  /* Controllers */
  late final ScrollController scrollController;

  /* Intents */

  // 설정 메뉴가 클릭 되었을 때
  void onSettingMenuTapped(SettingMenu selectedMenu) {
    switch (selectedMenu) {
      case SettingMenu.logOut:
        _remindLogOutEvent();
        break;
      case SettingMenu.termsAndPolicy:
        _goToTermAndPolicyPage();
        break;
      case SettingMenu.feedbackAndCs:
        _goToFeedbackPage();
        break;
      case SettingMenu.withdrawal:
        _remindWithdrawalEvent();
        break;
    }
  }

  /// 하단 상단 Gradient Box Visibility 여부를 조절하는 메소드.
  /// 렌더링을 최소화
  void setGradientBoxVisibility() {
    if (scrollController.offset >= 11 &&
        hideGradient == true &&
        scrollController.position.userScrollDirection ==
            ScrollDirection.reverse) {
      hideGradient = false;
      notifyListeners();
      return;
    } else if (scrollController.offset >= 20) {
      return;
    } else {
      if (hideGradient == false &&
          scrollController.position.userScrollDirection ==
              ScrollDirection.forward) {
        hideGradient = true;
        notifyListeners();
      }
    }
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



  // 유저 로컬 데이터 삭제
  void clearUserLocalData() {
    final response = _userRepository.clearUserLocalData();
    response.fold(
      onSuccess: (_) {},
      onFailure: (e) {
        log('SettingViewModel : $e');
      },
    );
  }

  // 프로필 설정 이동
  void routeToProfileSetting() {
    context.push(AppRoutes.tabs + AppRoutes.setting + AppRoutes.profileSetting);
  }

  // 탭이 선택되었을 때
  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;
    await _fetchUserWatchHistory();
    loadingState = ViewModelLoadingState.done;
  }

  /* Getters */
  // 현재 버전 정보
  String get currentVersionNum => _userService.currentVersionNum;

  // 유저 간략 정보
  BehaviorSubject<UserModel> get userInfoSub => _userService.userInfo;

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
  }
}
