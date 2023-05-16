import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelApiImpl with FirestoreHelper implements ChannelApi {
  final _db = AppFireStore.getInstance;

  @override
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers() async {
    final docs = await getDocsByOrderWithLimit(
      'channel',
      orderFieldName: 'totalContent',
      limitCount: 20,
    );

    return docs.map((e) => ChannelBasicResponse.fromDocument(e)).toList();
  }

  @override
  Future<List<ChannelContentItemResponse>> loadChannelContents(
      ChannelContentsRequest request) async {
    final docs = await getDocumentsByFieldValue(
      'content',
      fieldName: 'channelRef',
      fieldValue: AppFireStore.getInstance.doc('/channel/${request.channelId}'),
      lastDocument: request.lastDocument,
      pageSize: LoadPagedChannelContentsUseCase.pageSize,
    );

    return docs.map((e) => ChannelContentItemResponse.fromDocument(e)).toList();
  }

  @override
  Future<void> setChannelField() async {
    // 채널 snapshot
    QuerySnapshot channelSnapshot = await _db.collection('channel').get();

    // 채널 Documents
    List<DocumentSnapshot> channelDocs = channelSnapshot.docs;

    // 채널 Documents loop
    await Future.forEach(channelDocs, (DocumentSnapshot e) async {
      // 콘텐츠 snapshot
      final contentSnapshot = await _db
          .collection('content')
          .where('channelRef',
              isEqualTo: AppFireStore.getInstance.doc('/channel/${e.id}'))
          .get();

      // 콘텐츠 개수
      final contentsLength = contentSnapshot.docs.length;
      print('/channel/${e.id}');
      await updateDocumentFieldsTest(
        'channel',
        docId: e.id,
        firstFieldName: 'totalContent',
        firstFieldData: contentsLength,
      ).whenComplete(() => print("${e.id} 저장 완료"));
    });
  }

  @override
  Future<void> removeZeroContainedChannel() async {
    // 채널 snapshot
    QuerySnapshot channelSnapshot = await _db.collection('channel').get();

    // 채널 Documents
    List<DocumentSnapshot> channelDocs = channelSnapshot.docs;

    // 채널 Documents loop
    await Future.forEach(channelDocs, (DocumentSnapshot e) async {
      // 콘텐츠 snapshot
      final contentSnapshot = await _db
          .collection('content')
          .where('channelRef',
              isEqualTo: AppFireStore.getInstance.doc('/channel/${e.id}'))
          .get();

      // 콘텐츠 개수
      final contentsLength = contentSnapshot.docs.length;

      if (contentsLength == 0) {
        await deleteDocument('channel', docId: e.id);
        print("채널 삭제됨");
      }
    });
  }
}
