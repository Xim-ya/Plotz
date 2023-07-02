import 'package:soon_sak/data/api/user/response/user_watch_history_item_response.dart';

class UserWatchHistoryItem {
  final String originId;
  final String title;
  final String? posterImgUrl;

  UserWatchHistoryItem({
    required this.originId,
    required this.title,
    required this.posterImgUrl,
  });

  factory UserWatchHistoryItem.fromResponse(
    UserWatchHistoryItemResponse response,
  ) =>
      UserWatchHistoryItem(
        originId: response.originId,
        title: response.title,
        posterImgUrl: response.posterImgUrl,
      );
}
