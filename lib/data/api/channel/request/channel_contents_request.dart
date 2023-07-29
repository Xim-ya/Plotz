import 'package:cloud_firestore/cloud_firestore.dart';

class ChannelContentsRequest {
  final String channelId;
  final DocumentSnapshot? lastDocument;

  ChannelContentsRequest({
    required this.channelId,
    required this.lastDocument,
  });


}
