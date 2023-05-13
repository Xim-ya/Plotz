import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/utilities/result.dart';

abstract class ChannelRepository {
  Future<Result<List<ChannelModel>>> loadChannelsBaseOnSubscribers();
}