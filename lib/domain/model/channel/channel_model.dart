import 'package:soon_sak/data/api/channel/response/channel_response.dart';

class ChannelModel {
  final String name;
  final String logoImgUrl;
  final int subscribersCount;

  ChannelModel(
      {required this.name,
      required this.logoImgUrl,
      required this.subscribersCount});

  factory ChannelModel.fromResponse(ChannelBasicResponse response) =>
      ChannelModel(
        name: response.name,
        logoImgUrl: response.logoImgUrl,
        subscribersCount: response.subscribersCount,
      );
}
