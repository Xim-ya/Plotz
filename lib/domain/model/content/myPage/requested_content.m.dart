import 'package:soon_sak/data/api/user/response/requested_content.dart';
import 'package:soon_sak/domain/enum/requested_content_status.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class RequestedContent {
  final String id;
  final String title;
  final RequestedContentStatus status;
  final MediaType contentType;
  final String? posterImgUrl;
  final String? releasedDate;
  final String requestedDate;

  RequestedContent({
    required this.id,
    required this.title,
    required this.contentType,
    required this.status,
    required this.posterImgUrl,
    required this.releasedDate,
    required this.requestedDate,
  });

  factory RequestedContent.fromResponse(RequestedContentResponse response) =>
      RequestedContent(
        id: response.id,
        title: response.title,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        status: RequestedContentStatus.fromKeyValue(
            key: response.statusKey,
            pendingReason:
                response.statusKey == 2 ? response.reasonOfPending : null),
        posterImgUrl: response.posterImgUrl,
        releasedDate: response.releaseDate,
        requestedDate: Formatter.parseDateToyyyyMMdd(
            DateTime.parse(response.requestDate.toDate().toString())),
      );
}
