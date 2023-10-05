import 'dart:developer';

import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/myPage/requested_content.m.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

part 'controllerResources/my_page_view_model_menu_event.part.dart'; // 메뉴 선택 이벤트

class MyPageViewModel extends BaseViewModel {
  MyPageViewModel({
    required UserRepository userRepository,
    required UserService userService,
    required SignOutUseCase signOutHandlerUseCase,
    required CheckVersionAndNetworkUseCase checkVersionAndNetworkUseCase,
  })  : _userService = userService,
        _userRepository = userRepository,
        _checkVersionAndNetworkUseCase = checkVersionAndNetworkUseCase,
        _signOutHandlerUseCase = signOutHandlerUseCase;

  /* Data Modules */
  final UserService _userService;
  final UserRepository _userRepository;

  /* Variables */
  List<SettingMenu> settingOptions = SettingMenu.values;

  bool hideGradient = true; // 앱바 배경색 노출 여부
  BehaviorSubject<List<UserWatchHistoryItem>> get watchHistorySub =>
      _userService.userWatchHistory;

  /* UseCase*/
  final SignOutUseCase _signOutHandlerUseCase;
  final CheckVersionAndNetworkUseCase _checkVersionAndNetworkUseCase;

  /* Controllers */
  late final ScrollController scrollController;

  /* Intents */

  // 요청 콘텐츠 보드 페이지로 이동
  void routeToRequestedContentBoard() {
    if (userRequestedContents.hasError) {
      AlertWidget.newToast(context, message: '데이터를 불러오지 못하였습니다');
    }

    context.push(AppRoutes.requestedContent,
        extra: {'arg1': userRequestedContents.valueOrNull});
  }

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

  Future<void> _fetchUserRequestedContents() async {
    await _userService.updateUserRequestedContents();
    notifyListeners();
    print("UPDATED");
  }

  // 유저 시청 기록 호출
  Future<void> _fetchUserWatchHistory() async {
    await _userService.updateUserWatchHistory();

    notifyListeners();
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

  // 콘텐츠 상세 페이지로 이동
  void routeToContentDetail(ContentArgumentFormat routingArgument) {
    context.push(AppRoutes.contentDetail,
        extra: {'arg1': routingArgument, 'arg2': true});
  }

  // 탭이 선택되었을 때
  Future<void> prepare() async {
    loadingState = ViewModelLoadingState.loading;

    print("aim");
    await Future.wait(
        [_fetchUserWatchHistory(), _fetchUserRequestedContents()]);
    loadingState = ViewModelLoadingState.done;
  }

  /* Getters */
  // 현재 버전 정보
  String get currentVersionNum => _checkVersionAndNetworkUseCase.appVersionNum;

  // 유저 간략 정보
  BehaviorSubject<UserModel> get userInfoSub => _userService.userInfo;

  // 유저의 요청중인 콘텐츠
  BehaviorSubject<List<RequestedContent>> get userRequestedContents =>
      _userService.waitingRequestedContents;

  @override
  Future<void> onInit() async {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(setGradientBoxVisibility);
  }
}
