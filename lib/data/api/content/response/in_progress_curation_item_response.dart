import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class InProgressCurationItemResponse {
  final String curatorDisplayName;
  final String curatorProfileImgUrl;
  final String requestDate;
  final String status;
  final String title;
  final String posterImgUrl;
  final String videoId;

  InProgressCurationItemResponse({
    required this.curatorDisplayName,
    required this.curatorProfileImgUrl,
    required this.requestDate,
    required this.status,
    required this.title,
    required this.posterImgUrl,
    required this.videoId,
  });

  factory InProgressCurationItemResponse.fromDocument(DocumentSnapshot snapshot,
      {required String curatorName, required String curatorImg}) {
    return InProgressCurationItemResponse(
      curatorDisplayName: curatorName,
      curatorProfileImgUrl: curatorImg,
      posterImgUrl: snapshot.get('posterImgUrl'),
      requestDate:
          DateFormat('yyyy-MM-dd').format(snapshot.get('requestDate').toDate()),
      status: snapshot.get('status'),
      title: snapshot.get('title'),
      videoId: snapshot.get('videoId'),
    );
  }
}
