import 'package:soon_sak/domain/enum/requested_content_status.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentRequest {
  final String contentId;
  final String title;
  final String userId;
  final String? releaseDate;
  final String? posterImgUrl;

  ContentRequest({
    required this.contentId,
    required this.title,
    required this.userId,
    required this.releaseDate,
    required this.posterImgUrl,
  });

  Map<String, dynamic> toMap() {
    final data = {
      'title': title,
      'requestDate': FieldValue.serverTimestamp(),
      'releaseDate': releaseDate,
      'userId': userId,
      'contentId': contentId,
      'posterImgUrl': posterImgUrl,
      'statusKey': RequestedContentStatus.waiting.key,
    };

    return data;
  }
}
