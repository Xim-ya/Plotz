import 'package:soon_sak/utilities/index.dart';

class CurationContent {
  final String id;
  final String videoId;
  final String title;
  final String requestDate;
  final CurationStatus status;
  final String? posterImgUrl;
  late final String? curatorName;
  late final String? curatorProfileImgUrl;

  CurationContent({
    required this.title,
    required this.id,
    required this.videoId,
    required this.requestDate,
    required this.status,
    required this.posterImgUrl,
    required this.curatorName,
    required this.curatorProfileImgUrl,
  });

  factory CurationContent.fromResponse(CurationContentResponse response) =>
      CurationContent(
        id: response.id,
        title: response.title,
        posterImgUrl: response.posterImgUrl,
        curatorName: response.curatorDisplayName,
        curatorProfileImgUrl: response.curatorProfileImgUrl,
        videoId: response.videoId,
        requestDate: response.requestDate,
        status: CurationStatus.fromOriginString(response.status),
      );
}
