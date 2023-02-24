import 'package:soon_sak/utilities/index.dart';

class WatchingHistoryRequest {
  final String userId;
  final String originId;
  final String videoId;

  WatchingHistoryRequest({required this.userId, required this.originId, required this.videoId});

  Map<String, dynamic> toMap({required DocumentReference contentRef}) {
    final data = {
      'contentRef': contentRef,
      'watchedDate': FieldValue.serverTimestamp(),
      'videoId' : videoId,
    };

    return data;
  }
}
