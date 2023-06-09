import 'package:soon_sak/utilities/index.dart';

class ChannelBasicResponse {
  final String name;
  final int subscribersCount;
  final String logoImgUrl;
  final String channelId;
  final int totalContentCount;

  ChannelBasicResponse({
    required this.name,
    required this.subscribersCount,
    required this.logoImgUrl,
    required this.channelId,
    required this.totalContentCount,
  });

  factory ChannelBasicResponse.fromDocument(DocumentSnapshot snapshot) {
    return ChannelBasicResponse(
      name: snapshot.get('name'),
      subscribersCount: snapshot.get('subscribersCount'),
      logoImgUrl: snapshot.get('logoImgUrl'),
      totalContentCount: snapshot.get('totalContent'),
      channelId: snapshot.id,
    );
  }
}
