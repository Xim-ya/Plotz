import 'package:soon_sak/utilities/index.dart';

class UserWatchHistoryItemResponse {
  final String originId;
  final String posterImgUrl;
  final String videoId;

  UserWatchHistoryItemResponse({
    required this.originId,
    required this.posterImgUrl,
    required this.videoId,
  });

  factory UserWatchHistoryItemResponse.fromResponseDoc(
      {required DocumentSnapshot contentDoc,
      required DocumentSnapshot doc,}) {
    return UserWatchHistoryItemResponse(
      originId: contentDoc.get('id'),
      posterImgUrl: contentDoc.get('posterImgUrl'),
      videoId: doc.get('videoId'),
    );
  }
}
