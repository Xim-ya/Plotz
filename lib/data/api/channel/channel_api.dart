import 'package:soon_sak/data/api/channel/request/channe_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/channel/response/channel_response.dart';

abstract class ChannelApi {
  // 채널 리스트 호출, 구독자 높은 순으로, 최대 20
  Future<List<ChannelBasicResponse>> loadChannelsBaseOnSubscribers();

  // 특정 채널의 콘텐츠 리스트 호출
  Future<List<ChannelContentItemResponse>> loadPagedChannelContents(
      ChannelContentsRequest request);

  /* 임시 api method */
  Future<void> setChannelField();
  Future<void> removeZeroContainedChannel();
  Future<void> updateSeasonContentField();
  Future<void> getTwoFace();
}
