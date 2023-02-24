import 'package:soon_sak/utilities/index.dart';

class ContentRequest {
  final String contentId;
  final String title;
  final String userId;

  ContentRequest({
    required this.contentId,
    required this.title,
    required this.userId,
  });

  Map<String, dynamic> toMap() {
    final data = {
      'title': title,
      'requestDate': FieldValue.serverTimestamp(),
      'userId': userId,
      'contentId' : contentId,
    };

    return data;
  }
}
