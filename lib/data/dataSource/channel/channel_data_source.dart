import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

abstract class ChannelDataSource {
  // 채널 리스트 호출, 구독자 높은 순으로
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers();

  // 특정 채널의 콘텐츠 리스트 호출 (페이징 & 10 limit 로직 적용)
  Future<List<ChannelContentItemResponse>> loadChannelContents(
      ChannelContentsRequest request);
}
