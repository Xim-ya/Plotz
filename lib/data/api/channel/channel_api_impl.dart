import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';
import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/presentation/screens/channel/channel_detail_view_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelApiImpl with FirestoreHelper implements ChannelApi {
  @override
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers() async {
    final docs = await getDocsByOrderWithLimit(
      'channel',
      orderFieldName: 'subscribersCount',
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
}
