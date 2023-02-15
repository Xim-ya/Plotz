import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

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

  // 애플 로그인 시
  factory UserModel.fromAppleSignInRes(
          {required AuthorizationCredentialAppleID response}) =>
      UserModel(
        displayName: '${response.familyName} ${response.givenName}',
        email: response.email,
        id: response.identityToken,
        token: UserToken(
            idToken: response.identityToken,
            accessToken: response.authorizationCode),
        photoUrl: null,
      );
}

class UserToken {
  final String? idToken;
  final String? accessToken;

  UserToken({required this.idToken, required this.accessToken});
}
