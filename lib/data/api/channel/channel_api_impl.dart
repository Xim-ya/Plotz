import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';

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
}
