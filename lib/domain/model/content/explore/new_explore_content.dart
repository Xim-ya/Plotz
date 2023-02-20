import 'package:soon_sak/data/api/content/response/explore_content_response.dart';

class NewExploreContent {
  final String originId;
  final String posterImgUrl;
  final String releaseDate;
  final String title;
  final String videoTitle;
  final String channelName;
  final String channelLogoImgUrl;
  final int subscribersCount;

  NewExploreContent(
      {required this.originId,
      required this.posterImgUrl,
      required this.releaseDate,
      required this.title,
      required this.videoTitle,
      required this.channelName,
      required this.subscribersCount,
      required this.channelLogoImgUrl});

  factory NewExploreContent.fromResponse(ExploreContentResponse response) {
    return NewExploreContent(
      originId: response.id,
      posterImgUrl: response.posterImgUrl,
      releaseDate: response.releaseDate,
      title: response.title,
      videoTitle: response.videoTitle,
      channelName: response.channelName,
      channelLogoImgUrl: response.channelLogoImgUrl,
      subscribersCount: response.subscribersCount,
    );
  }
}
