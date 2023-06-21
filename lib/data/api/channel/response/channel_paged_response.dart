import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

class ChannelPagedResponse {
  final List<ChannelBasicResponse> channelList;
  final DocumentSnapshot? lastDocument;

  ChannelPagedResponse({required this.channelList, required this.lastDocument});

  factory ChannelPagedResponse.fromDocument(
    List<DocumentSnapshot> docs,
  ) {
    return ChannelPagedResponse(
        channelList:
            docs.map((e) => ChannelBasicResponse.fromDocument(e)).toList(),
        lastDocument: docs.last);
  }
}
