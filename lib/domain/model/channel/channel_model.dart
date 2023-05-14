import 'package:soon_sak/data/api/channel/response/channel_response.dart';

class ChannelModel {
  final String name;
  final String channelId;
  final String logoImgUrl;
  final int subscribersCount;

  ChannelModel(
      {required this.name,
      required this.channelId,
      required this.logoImgUrl,
      required this.subscribersCount});

  factory ChannelModel.fromResponse(ChannelBasicResponse response) =>
      ChannelModel(
        name: response.name,
        channelId: response.channelId,
        logoImgUrl: response.logoImgUrl,
        subscribersCount: response.subscribersCount,
      );
}
