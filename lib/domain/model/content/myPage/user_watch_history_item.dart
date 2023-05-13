import 'package:soon_sak/data/api/user/response/user_watch_history_item_response.dart';

class UserWatchHistoryItem {
  final String originId;
  final String videoId;
  final String? posterImgUrl;

  UserWatchHistoryItem({
    required this.originId,
    required this.videoId,
    required this.posterImgUrl,
  });

  factory UserWatchHistoryItem.fromResponse(
          UserWatchHistoryItemResponse response,) =>
      UserWatchHistoryItem(
        originId: response.originId,
        videoId: response.videoId,
        posterImgUrl: response.posterImgUrl,
      );
}
