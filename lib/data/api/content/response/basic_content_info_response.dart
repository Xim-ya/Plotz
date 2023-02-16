import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/utilities/index.dart';

@JsonSerializable(createToJson: false)
class BasicContentInfoResponse {
  final String id;
  final String title;
  final String videoId;
  final String releaseDate;
  final String posterImgUrl;

  BasicContentInfoResponse({
    required this.id,
    required this.title,
    required this.videoId,
    required this.releaseDate,
    required this.posterImgUrl,
  });

  factory BasicContentInfoResponse.fromDocumentSnapshot(
      DocumentSnapshot<Object?> snapshot) {
    return BasicContentInfoResponse(
      id: snapshot.get('id'),
      title: snapshot.get('title'),
      videoId: snapshot.get('videoId'),
      releaseDate: snapshot.get('releaseDate'),
      posterImgUrl: snapshot.get('posterImgUrl'),
    );
  }
}
