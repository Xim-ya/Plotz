import 'package:cloud_firestore/cloud_firestore.dart';

class ChannelContentItemResponse {
  final String id;
  final String posterImgUrl;
  final String videoTitle;
  final DocumentSnapshot originDoc;

  ChannelContentItemResponse(
      {required this.id,
      required this.posterImgUrl,
      required this.videoTitle,
      required this.originDoc});

  factory ChannelContentItemResponse.fromDocument(DocumentSnapshot doc) =>
      ChannelContentItemResponse(
        id: doc.get('id'),
        posterImgUrl: doc.get('posterImgUrl'),
        videoTitle: doc.get('videoTitle'),
        originDoc: doc,
      );
}
