import 'package:soon_sak/utilities/index.dart';

class UserResponse {
  final String? name;
  final String? nickName;
  final String? email;
  late String? id;
  late String? photoUrl;
  final UserToken? token;
  final Sns provider;

  UserResponse({
    required this.provider,
    this.id,
    this.name,
    this.email,
    this.photoUrl,
    this.token,
    this.nickName,
  });

  // FirebaseStore
  factory UserResponse.fromDocumentRes(DocumentSnapshot doc) => UserResponse(
    name: doc.get('name'),
    id: doc.get('id'),
    email: doc.get('email'),
    photoUrl: doc.get('photoUrl'),
    nickName: doc.get('nickName'),
    provider: Sns.fromOriginString(
      doc.get('provider'),
    ),
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