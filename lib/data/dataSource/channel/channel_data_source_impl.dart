import 'package:soon_sak/data/api/channel/channel_api.dart';
import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_paged_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';
import 'package:soon_sak/data/dataSource/channel/channel_data_source.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements ChannelDataSource {
  ChannelDataSourceImpl(this._api);

  final ChannelApi _api;

  @override
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers() {
    return loadResponseOrThrow(() => _api.loadChannelSortedByContentCount());
  }

  @override
  Future<ChannelPagedResponse> loadPagedChannels(
      DocumentSnapshot? lastDocument) {
    return loadResponseOrThrow(() => _api.loadPagedChannels(lastDocument));
  }

  @override
  Future<List<ChannelContentItemResponse>> loadChannelContents(
      ChannelContentsRequest request) {
    return loadResponseOrThrow(() => _api.loadPagedChannelContents(request));
  }

  @override
  Future<ChannelBasicResponse> loadChannelById(String channelId) {
    return loadResponseOrThrow(() => _api.loadChannelById(channelId));
  }
}
