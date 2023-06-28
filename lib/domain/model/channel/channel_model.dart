import 'package:soon_sak/data/api/channel/response/channel_response.dart';

class ChannelModel {
  final String name;
  final String channelId;
  final String logoImgUrl;
  final int subscribersCount;
  final int totalContentCount;

  ChannelModel({
    required this.name,
    required this.channelId,
    required this.logoImgUrl,
    required this.subscribersCount,
    required this.totalContentCount,
  });

  factory ChannelModel.fromResponse(ChannelBasicResponse response) =>
      ChannelModel(
        name: response.name,
        channelId: response.channelId,
        logoImgUrl: response.logoImgUrl,
        totalContentCount: response.totalContentCount,
        subscribersCount: response.subscribersCount,
      );
}
