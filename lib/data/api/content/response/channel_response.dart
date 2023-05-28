import 'package:soon_sak/utilities/index.dart';

class ChannelResponse {
  final String? id;
  final String? name;
  final int? subscribersCount;
  final String? logoImgUrl;
  final String? description;

  ChannelResponse({
    this.id,
    this.name,
    this.subscribersCount,
    this.logoImgUrl,
    this.description,
  });

  // FirebaseStore
  factory ChannelResponse.fromDocumentRes(DocumentSnapshot doc) =>
      ChannelResponse(
        id: doc.id,
        name: doc.get('name'),
        subscribersCount: doc.get('subscribersCount'),
        logoImgUrl: doc.get('logoImgUrl'),
        description: doc.get('description'),
      );
}
