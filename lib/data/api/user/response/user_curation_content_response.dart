import 'package:intl/intl.dart';
import 'package:soon_sak/utilities/index.dart';

class UserCurationContentResponse {
  final String requestDate;
  final String status;
  final String title;
  final String posterImgUrl;
  final String videoId;
  final String id;

  UserCurationContentResponse({
    required this.requestDate,
    required this.status,
    required this.title,
    required this.posterImgUrl,
    required this.id,
    required this.videoId,
  });

  factory UserCurationContentResponse.fromDocument(DocumentSnapshot snapshot,
      {required String curatorName, required String curatorImg,}) {
    return UserCurationContentResponse(
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