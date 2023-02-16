import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class UserService extends GetxService {
  UserService(this._authRepository);

  final AuthRepository _authRepository;

  late final bool isUserSignIn; // 유저 로그인 여부
  UserModel? userInfo; // 유저 정보

  Future<void> getUserInfo() async {
    final response = await _authRepository.loadUserInfo();
    response.fold(
      onSuccess: (data) {
        userInfo = data;
      },
      onFailure: (e) {
        log('UserService : $e');
      },
    );
  }

  Future<void> checkUserSignInState() async{
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

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    checkUserSignInState();
  }

  static UserService get to => Get.find();
}
