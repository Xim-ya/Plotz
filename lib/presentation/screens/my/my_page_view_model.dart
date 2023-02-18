import 'dart:developer';
import 'package:soon_sak/data/repository/user/user_repository.dart';
import 'package:soon_sak/domain/model/content/myPage/user_curation_summary.dart';
import 'package:soon_sak/utilities/index.dart';

class MyPageViewModel extends BaseViewModel {
  MyPageViewModel(this._signOutHandlerUseCase, this._userRepository);

  /* Variables */
  UserCurationSummary? curationSummary;

  final SignOutUseCase _signOutHandlerUseCase;
  UserModel? userInfo;

  String? get displayName => userInfo?.nickName ?? userInfo?.name;

  /* Data Modules */
  final UserRepository _userRepository;

  // 유저 정보 호출
  Future<void> getUserInfo() async {
    await UserService.to.getUserInfo(); // fetch 메소드 실행
    userInfo = UserService.to.userInfo;
    update();
  }

  /* Intents */
  // 큐레이팅 내역 스크린으로 라우팅
  void routeToCurationHistory() {
    Get.toNamed(AppRoutes.curationHistory);
  }

  // 로그아웃
  Future<void> signOut(Sns social) async {
    final result = await _signOutHandlerUseCase.call(social);
    result.fold(
      onSuccess: (_) {
        Get.offAllNamed(AppRoutes.login);
      },
      onFailure: (e) {
        AlertWidget.animatedToast('로그아웃에 실패했습니다. 다시 시도 시도해주세요');
        log(e.toString());
      },
    );
  }

  // 유저 큐레이션 내역 요약 정보 호출
  Future<void> fetchUserCurationSummary() async {
    final userId = UserService.to.userInfo!.id!;
    final response = await _userRepository.loadUserCurationSummary(userId);
    response.fold(
      onSuccess: (data) {
        curationSummary = data;
        update();
      },
      onFailure: (e) {
        log('MyPageViewModel $e');
      },
    );
  }

  @override
  Future<void> onInit() async {
    super.onInit();
    await getUserInfo();
    await fetchUserCurationSummary();

  }
}
