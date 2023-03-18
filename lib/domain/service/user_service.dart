import 'dart:developer';

import 'package:soon_sak/utilities/index.dart';

class UserService extends GetxService {
  UserService(this._authRepository, this._userRepository);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final String currentVersionNum;
  late final bool isUserSignIn; // 유저 로그인 여부
  final Rxn<UserModel> userInfo = Rxn(); // 유저 정보
  final Rxn<List<UserWatchHistoryItem>> userWatchHistory = Rxn(); // 유저 시청 기록

  /* Intents */
  // 유저 시청 기록 호출
  Future<void> updateUserWatchHistory() async {
    final response =
        await _userRepository.loadUserWatchHistory(userInfo.value!.id!);
    response.fold(
      onSuccess: (data) {
        userWatchHistory.value = data;
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  // 유저 정보 호출
  Future<void> getUserInfo() async {
    final response = await _authRepository.loadUserInfo();
    response.fold(
      onSuccess: (data) {
        userInfo.value = data;
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  // 유저 접속일 최신화
  Future<void> updateUserLoginDate(String userId) async {
    final response = await _authRepository.updateLoginDate(userId);
    response.fold(
      onSuccess: (_) {},
      onFailure: (e) {
        log('UserService - 유저 접속일 최신화 실패 $e');
      },
    );
  }

  // 유저 등록 여부 확인
  Future<void> checkUserSignInState() async {
    final response = await _authRepository.isUserSignedIn();
    response.fold(
      onSuccess: (data) {
        isUserSignIn = data;
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  /// 네트워크 상태를 관찰하는 메소드
  /// 네트워크가 불안정할 시 snackBar message를 보여줌
  /// 맨 처음 로드시에는 무조건 [ConnectivityResult.none]을 반환하여
  /// [isReadyToActivate] boolean 값으로 snackbar message 노출 여부를 결정함
  void listenNetworkConnection() {
    bool isReadyToActivate = false;
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (isReadyToActivate && result == ConnectivityResult.none) {
        Get.snackbar('네트워크 불안정', 'Wi-Fi 또는 데이터를 활성화 해주세요.');
      } else {
        isReadyToActivate = true;
      }
    });
  }

  // 리소스 initialize 메소드
  Future<void> prepare() async {
    await getUserInfo();
    await checkUserSignInState();
    listenNetworkConnection();
  }
}
