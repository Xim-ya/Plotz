import 'package:cloud_firestore/cloud_firestore.dart';

class ChannelContentItemResponse {
  final String id;
  final String posterImgUrl;
  final String videoTitle;
  final String title;
  final DocumentSnapshot originDoc;

  ChannelContentItemResponse(
      {required this.id,
      required this.posterImgUrl,
      required this.title,
      required this.videoTitle,
      required this.originDoc});

  factory ChannelContentItemResponse.fromDocument(DocumentSnapshot doc) =>
      ChannelContentItemResponse(
        id: doc.get('id'),
        title: doc.get('title'),
        posterImgUrl: doc.get('posterImgUrl'),
        videoTitle: doc.get('videoTitle'),
        originDoc: doc,
      );
}
