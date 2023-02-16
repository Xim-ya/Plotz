import 'package:soon_sak/utilities/index.dart';

class UserModel {
  final String? name;
  final String? nickName;
  final String? email;
  late String? id;
  final String? photoUrl;
  final UserToken? token;
  final Sns provider;

  UserModel({
    required this.provider,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
    this.nickName,
  });

  // FirebaseStore
  factory UserModel.fromDocumentRes(DocumentSnapshot doc) => UserModel(
        name: doc.get('name'),
        id: doc.get('id'),
        email: doc.get('email'),
        photoUrl: doc.get('photoUrl'),
        nickName: doc.get('nickName'),
        provider: Sns.fromOriginString(
          doc.get('provider'),
        ),
      );

  // 구글 로그인 시
  factory UserModel.fromGoogleSignInRes(
      {required GoogleSignInAccount account,
      required GoogleSignInAuthentication authentication}) {
    return UserModel(
      name: account.displayName,
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
        name: '${response.familyName}${response.givenName}',
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
      'name': name,
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
