


import 'package:soon_sak/data/api/channel/channel_api.dart';
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
    return loadResponseOrThrow(() => _api.loadChannelsBaseOnSubscribers());
  }



}
