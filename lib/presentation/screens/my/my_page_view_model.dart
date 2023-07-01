import 'dart:developer';
import 'package:go_router/go_router.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/utilities/index.dart';

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
  UserCurationSummary? curationSummary; //  큐레이션 내역 요약 정보
  BehaviorSubject<List<UserWatchHistoryItem>> get watchHistorySub =>
      _userService.userWatchHistory;

  /* UseCase*/
  final SignOutUseCase _signOutHandlerUseCase;

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

  // 회원탈퇴
  Future<void> withDrawUser() async {
    final response = await _userRepository.withdrawUser();
    response.fold(
      onSuccess: (data) {
        signOut().whenComplete(() {
          clearUserLocalData();
          AlertWidget.newToast(message: '회원탈퇴 처리 되었습니다', context);
        });
      },
      onFailure: (e) {
        log('SettingViewModel : $e');
      },
    );
  }

  //개인정보 및 약관으로 이동
  Future<void> routeToTerms() async {
    await launchUrl(
      Uri.parse(
        'https://puzzle-heather-876.notion.site/c2a63470f4ad471a95e57009ba9dfa3a',
      ),
      mode: LaunchMode.externalApplication,
    );
  }

  // 이메일 피드백
  Future<void> goToKakaoOneonOne() async {
    await launchUrl(
      Uri.parse('http://pf.kakao.com/_XVDxmxj/chat'),
      mode: LaunchMode.externalApplication,
    );
  }

  // 회원탈퇴 안내 모달
  void showWithdrawnInoModal() {
    showDialog(
      context: context,
      builder: (_) => AppDialog.dividedBtn(
        title: '회원 탈퇴',
        description: '탈퇴 시 기존 큐레이팅 내역 및 개인정보가 삭제됩니다.\n정말 탈퇴하시겠습니까?',
        leftBtnContent: '취소',
        rightBtnContent: '탈퇴',
        // TODO: 실제 요청 로직 추가 필요
        onRightBtnClicked: withDrawUser,
        onLeftBtnClicked: context.pop,
      ),
    );
  }

  // 로그아웃
  Future<void> signOut() async {
    final userPlatform = _userService.userInfo.value.provider!;
    final result = await _signOutHandlerUseCase.call(userPlatform);
    result.fold(
      onSuccess: (_) {
        context.go(AppRoutes.login);
        clearUserLocalData();
        TabsBinding.unRegisterDependencies();
        LoginBinding.dependencies();
      },
      onFailure: (e) {
        AlertWidget.newToast(message: '로그아웃에 실패했습니다. 다시 시도 시도해주세요', context);
        log(e.toString());
      },
    );
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

  /* Getters */
  String get currentVersionNum => _userService.currentVersionNum;

  @override
  Future<void> onInit() async {
    super.onInit();
  }
}
