import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class CurationContentResponse {
  late final String? curatorDisplayName;
  late final String? curatorProfileImgUrl;
  final String requestDate;
  final String status;
  final String title;
  final String? posterImgUrl;
  final String videoId;
  final String id;

  CurationContentResponse({
    this.curatorDisplayName,
    this.curatorProfileImgUrl,
    required this.requestDate,
    required this.status,
    required this.title,
    required this.posterImgUrl,
    required this.id,
    required this.videoId,
  });

  factory CurationContentResponse.fromDocument(DocumentSnapshot snapshot,
      {required String? curatorName, required String? curatorImg,}) {
    return CurationContentResponse(
      curatorDisplayName: curatorName,
      curatorProfileImgUrl: curatorImg,
      posterImgUrl: snapshot.get('posterImgUrl'),
      requestDate:
          DateFormat('yyyy-MM-dd').format(snapshot.get('requestDate').toDate()),
      status: snapshot.get('status'),
      title: snapshot.get('title'),
      id: snapshot.get('id'),
      videoId: snapshot.get('videoId'),
    );
  }

  factory CurationContentResponse.fromUserResponseDoc(
    DocumentSnapshot snapshot,
  ) {
    return CurationContentResponse(
      posterImgUrl: snapshot.get('posterImgUrl'),
      requestDate:
          DateFormat('yyyy-MM-dd').format(snapshot.get('requestDate').toDate()),
      status: snapshot.get('status'),
      title: snapshot.get('title'),
      id: snapshot.get('id'),
      videoId: snapshot.get('videoId'),
    );
  }
}
