import 'package:soon_sak/utilities/index.dart';

class WatchingHistoryRequest {
  final String userId;
  final String originId;

  WatchingHistoryRequest({required this.userId, required this.originId});

  Map<String, dynamic> toMap({required DocumentReference contentRef}) {
    final data = {
      'contentRef': contentRef,
      'watchedDate': FieldValue.serverTimestamp(),
    };

    return data;
  }
}
