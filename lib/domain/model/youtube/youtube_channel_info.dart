import 'package:soon_sak/utilities/index.dart';

class YoutubeChannelInfo {
  final String name; // 채널 이름
  final int? subscriberCount; // 구독자 수
  final String? description; // 채널 설명
  final String channelImgUrl; // 채널 이미지
  final String url; // 채널 주소

  YoutubeChannelInfo(
      {required this.name,
      required this.channelImgUrl,
      required this.subscriberCount,
      required this.description,
      required this.url});

  factory YoutubeChannelInfo.fromResponse(
      {required Channel response, required ChannelAbout detailResponse}) {
    return YoutubeChannelInfo(
        name: detailResponse.title,
        channelImgUrl: response.logoUrl,
        subscriberCount: response.subscribersCount,
        description: detailResponse.description,
        url: response.url);
  }
}
