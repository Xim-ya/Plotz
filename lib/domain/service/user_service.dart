import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class UserService extends GetxService {
  UserService(this._authRepository, this._userRepository);

  final AuthRepository _authRepository;
  final UserRepository _userRepository;

  late final bool isUserSignIn; // 유저 로그인 여부
  final Rxn <UserModel> userInfo = Rxn(); // 유저 정보
  final Rxn<List<UserWatchHistoryItem>> userWatchHistory = Rxn(); // 유저 시청 기록

  /* Intents */
  // 유저 시청 기록 호출
  Future<void> updateUserWatchHistory() async {
    final response = await _userRepository.loadUserWatchHistory(userInfo.value!.id!);
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

  // 리소스 initialize 메소드
  Future<void> prepare() async {
    await getUserInfo();
    await checkUserSignInState();
  }


}
