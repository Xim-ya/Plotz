
import 'package:soon_sak/utilities/index.dart';

class UserModel {
  final String? displayName;
  final String? nickName;
  final String? email;
  late String id;
  final String? photoUrl;
  final UserToken? token;
  final Sns provider;

  UserModel({
    required this.provider,
    this.displayName,
    this.email,
    this.photoUrl,
    this.token,
    this.nickName,
  });

  // 구글 로그인 시
  factory UserModel.fromGoogleSignInRes(
      {required GoogleSignInAccount account,
      required GoogleSignInAuthentication authentication}) {
    return UserModel(
      displayName: account.displayName,
      email: account.email,
      provider: Sns.google,
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
        displayName: '${response.familyName}${response.givenName}',
        email: response.email,
        provider: Sns.apple,
        token: UserToken(
            idToken: response.identityToken,
            accessToken: response.authorizationCode),
      );

  // Instance -> Map (FireStore 저장 용도)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': displayName,
      'provider': provider.originString.toString(), // toString으로 포맷을 한번더 해줘야함
      'nickName': nickName,
      'photoUrl': photoUrl,
      'email': email,
    };
  }
}

class UserToken {
  final String? idToken;
  final String? accessToken;

  UserToken({required this.idToken, required this.accessToken});
}
