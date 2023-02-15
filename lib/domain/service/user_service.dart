import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:soon_sak/data/repository/auth/auth_repository.dart';

class UserService extends GetxService {
  UserService(this._authRepository);

  final AuthRepository _authRepository;

  late final bool isUserSignIn;

  void checkUserSignInState() {
    final response = _authRepository.isUserSignedIn();
    response.fold(
      onSuccess: (data) {
        isUserSignIn = data;
      },
      onFailure: (e) {
        log('UserService $e');
      },
    );
  }

  @override
  void onInit() {
    super.onInit();

    checkUserSignInState();
  }

  static UserService get to => Get.find();
}

