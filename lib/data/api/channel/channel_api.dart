import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class ChannelApi {
  // 채널 리스트 호출, 구독자 높은 순으로, 최대 20
  Future<List<ChannelBasicResponse>> loadChannelSortedByContentCount();

  // 채널 리스트 호츨, paged 호출방식
  Future<ChannelPagedResponse> loadPagedChannels(
      DocumentSnapshot? lastDocument);

  // 채널정보 호출, id값을 기준으로
  Future<ChannelBasicResponse> loadChannelById(String channelId);

  // 특정 채널의 콘텐츠 리스트 호출
  Future<List<ChannelContentItemResponse>> loadPagedChannelContents(
      ChannelContentsRequest request);

  /* 임시 api method */
  // Future<void> setChannelField();
  //
  // Future<void> removeZeroContainedChannel();
  //
  // Future<void> updateSeasonContentField();
  //
  // Future<void> getTwoFace();
  //
  // Future<void> checkUsercount();
  //
  // Future<void> checkYC();
}
