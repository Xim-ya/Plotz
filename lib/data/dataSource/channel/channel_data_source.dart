import 'package:soon_sak/data/api/channel/response/channel_response.dart';


abstract class ChannelDataSource {
  // 채널 리스트 호출, 구독자 높은 순으로
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers();
}
