import 'package:soon_sak/utilities/index.dart';

class ContentRegistrationRequest {
  final String originId;
  final FieldValue requestDate;
  final String title;
  final String? posterImgUrl;
  final String curatorId;
  final String status;
  final String videoId;

  ContentRegistrationRequest(
      {required this.originId,
      required this.requestDate,
      required this.title,
      required this.posterImgUrl,
      required this.curatorId,
      required this.status,
      required this.videoId});

  factory ContentRegistrationRequest.fromContentModelWithUserId(
          {required Content content, required String userId}) =>
      ContentRegistrationRequest(
        originId: Formatter.getOriginIdByTypeAndId(
            type: content.type!, id: content.id),
        requestDate: FieldValue.serverTimestamp(),
        title: content.detail!.title!,
        posterImgUrl: content.detail!.posterImgUrl,
        curatorId: userId,
        status: 'inProgress',
        videoId: content.videoId!,
      );

  // requset 포맷으로 변경
  Map<String, dynamic> toMap({required DocumentReference curatorRef}) {
    final data = {
      'id' : originId,
      'requestDate': FieldValue.serverTimestamp(),
      'title': title,
      'posterImgUrl': posterImgUrl,
      'curator': curatorRef, // 레퍼런스 타입
      'status': status,
      'videoId': videoId,
    };

    return data;
  }
}
