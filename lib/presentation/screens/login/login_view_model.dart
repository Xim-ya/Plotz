import 'dart:developer';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:uppercut_fantube/data/dataSource/auth/auth_data_source.dart';
import 'package:uppercut_fantube/data/repository/auth/auth_repository.dart';
import 'package:uppercut_fantube/domain/service/user_service.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class LoginViewModel extends BaseViewModel {
  LoginViewModel(this._userService, this._authDataSource, this._authRepository);

  bool isUserSignIn = false;

  final UserService _userService;
  final AuthDataSource _authDataSource;
  final AuthRepository _authRepository;

  Future<void> checkUserState() async {
    final aim = _userService.checkUserSignInState();
    print('결과 $aim');
  }

  Future<void> googleSignIn() async {
    await _authRepository.getGoogleUserInfo();
  }

  Future<void> signInWithGoogle() async {
    /// Trigger the authentication flow...
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    /// Obtain the auth details from the request...
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    /// Create a new credential...
    // final credential = GoogleAuthProvider.credential(
    //   accessToken: googleAuth?.accessToken,
    //   idToken: googleAuth?.idToken,
    // );
/*
    print('==============idToken1 ${googleUser?.id}');
    print('==============idToken2 ${googleAuth?.idToken}');

    final aim = await FirebaseAuth.instance.signInWithCredential(credential);
    print('==============idToken3(uid) ${aim.user?.uid}');
    print('==============idToken4(uid) ${aim.credential?.token}');*/

    print(googleAuth?.idToken);
  }

  Future<void> handleRoute() async {
    final response = _authRepository.isUserSignedIn();
    response.fold(
      onSuccess: (isUserSignIn) {
        if (isUserSignIn) {
          Get.toNamed(AppRoutes.tabs);
        }
      },
      onFailure: (e) {
        log(e.toString());
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    handleRoute();
  }
}
