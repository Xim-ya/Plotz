import 'package:soon_sak/utilities/index.dart';

class RequestedContentResponse {
  final String id;
  final String title;
  final int statusKey;
  final String? posterImgUrl;
  final String? releaseDate;
  final Timestamp requestDate;
  final String? reasonOfPending;

  RequestedContentResponse({
    required this.id,
    required this.title,
    required this.statusKey,
    required this.posterImgUrl,
    required this.releaseDate,
    required this.requestDate,
    required this.reasonOfPending,
  });

  // FirebaseStore
  factory RequestedContentResponse.fromDocumentRes(DocumentSnapshot doc) {
    final statusKey = doc.get('statusKey');

    return RequestedContentResponse(
      id: doc.get('contentId'),
      title: doc.get('title'),
      statusKey: statusKey,
      posterImgUrl: doc.get('posterImgUrl'),
      releaseDate: doc.get('releaseDate'),
      requestDate: doc.get('requestDate'),
      reasonOfPending: statusKey == 2 ? doc.get('reasonOfPending') : null,
    );
  }
}
