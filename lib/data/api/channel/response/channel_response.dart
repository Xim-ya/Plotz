import 'package:soon_sak/utilities/index.dart';

class ChannelBasicResponse {
  final String name;

  final int subscribersCount;

  final String logoImgUrl;

  ChannelBasicResponse(
      {required this.name,
      required this.subscribersCount,
      required this.logoImgUrl});

  factory ChannelBasicResponse.fromDocument(DocumentSnapshot snapshot) =>
      ChannelBasicResponse(
        name: snapshot.get('name'),
        subscribersCount: snapshot.get('subscribersCount'),
        logoImgUrl: snapshot.get('logoImgUrl'),
      );
}
