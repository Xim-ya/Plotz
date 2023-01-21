import 'package:uppercut_fantube/utilities/index.dart';

class ExploreContentYoutubeInfo {
  final String videoTitle; // 유튜브 비디오 제목
  final String channelImgUrl; // 유튜브 채널 이미지
  final String channelName; // 유튜브 채널 이름
  final int? subscribers;

  ExploreContentYoutubeInfo(
      {required this.videoTitle,
        required this.channelImgUrl,
        required this.channelName,
        required this.subscribers}); // 구독자 수

  factory ExploreContentYoutubeInfo.fromResponse(
      {required Channel channelRes, required Video videoRes}) {
    return ExploreContentYoutubeInfo(
      videoTitle: videoRes.title,
      channelImgUrl: channelRes.logoUrl,
      channelName: channelRes.title,
      subscribers: channelRes.subscribersCount,
    );
  }
}