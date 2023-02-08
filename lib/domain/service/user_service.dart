import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserService extends GetxService {
  late final bool isUserSignIn;

  bool checkUserSignInState()  {
    if (FirebaseAuth.instance.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  // 유저의 로그인 여부를 확인
  // Future<void> checkUserSignInState() async {
  //   FirebaseAuth.instance.authStateChanges().listen(
  //     (event) {
  //       if (event == null) {
  //         isUserSignIn = false;
  //         print("FALSE");
  //       } else {
  //         isUserSignIn = true;
  //         print("TRUE");
  //       }
  //     },
  //   );
  // }

  @override
  void onReady() {
    super.onReady();

    print("arang");
  }
}
