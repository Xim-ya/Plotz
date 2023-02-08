import 'package:google_sign_in/google_sign_in.dart';

class UserModel {
  final String? displayName;
  final String? email;
  final String? id;
  final String? photoUrl;
  final UserToken? token;

  UserModel({
    required this.displayName,
    required this.email,
    required this.id,
    required this.photoUrl,
    this.token,
  });


  // 구글 로그인 시
  factory UserModel.fromGoogleSignInRes(
      {required GoogleSignInAccount account,
      required GoogleSignInAuthentication authentication}) {
    return UserModel(
      displayName: account.displayName,
      email: account.email,
      id: account.id,
      photoUrl: account.photoUrl,
      token: UserToken(
          idToken: authentication.idToken,
          accessToken: authentication.accessToken),
    );
  }
}

class UserToken {
  final String? idToken;
  final String? accessToken;

  UserToken({required this.idToken, required this.accessToken});
}
