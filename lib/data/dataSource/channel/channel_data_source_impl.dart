import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
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
