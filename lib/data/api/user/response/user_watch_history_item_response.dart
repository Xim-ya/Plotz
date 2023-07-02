import 'package:soon_sak/utilities/index.dart';

class UserWatchHistoryItemResponse {
  final String originId;
  final String posterImgUrl;
  final String title;

  UserWatchHistoryItemResponse({
    required this.originId,
    required this.posterImgUrl,
    required this.title,
  });

  factory UserWatchHistoryItemResponse.fromResponseDoc({
    required DocumentSnapshot contentDoc,
    required DocumentSnapshot doc,
  }) {
    return UserWatchHistoryItemResponse(
      originId: contentDoc.get('id'),
      posterImgUrl: contentDoc.get('posterImgUrl'),
      title:  contentDoc.get('title'),
    );
  }
}
