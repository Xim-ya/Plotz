import 'package:soon_sak/utilities/index.dart';

class ChannelInfo {
  final String? id;
  final String? name;
  final int? subscribersCount;
  final String? logoImgUrl;
  final String description;

  ChannelInfo({
    required this.id,
    required this.name,
    required this.subscribersCount,
    required this.logoImgUrl,
    required this.description,
  });

  factory ChannelInfo.fromResponse(ChannelResponse response) => ChannelInfo(
        id: response.id,
        name: response.name,
        subscribersCount: response.subscribersCount,
        logoImgUrl: response.logoImgUrl,
        description: response.description ?? '설명 없음',
      );
}
