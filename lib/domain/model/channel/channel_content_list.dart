import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/domain/model/content/home/content_poster_shell.dart';

class ChannelContentList {
  final List<ContentPosterShell> contents;
  DocumentSnapshot lastDocument;

  ChannelContentList({required this.contents, required this.lastDocument});

  factory ChannelContentList.fromResponse(
          List<ChannelContentItemResponse> responseList,
          DocumentSnapshot lastDocument) =>
      ChannelContentList(
        contents: responseList
            .map((e) => ContentPosterShell.fromChannelContents(e))
            .toList(),
        lastDocument: lastDocument,
      );
}
