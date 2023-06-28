import 'package:soon_sak/data/api/channel/request/channel_contents_request.dart';
import 'package:soon_sak/data/api/channel/response/channel_paged_response.dart';
import 'package:soon_sak/domain/model/channel/channel_content_list.dart';
import 'package:soon_sak/domain/model/channel/channel_model.dart';
import 'package:soon_sak/domain/model/content/home/content_poster_shell.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class ChannelRepository {
  // 구독자수가 많은 순으로 채널 리스트 호출
  Future<Result<List<ChannelModel>>> loadChannelsBaseOnSubscribers();

  // 채널 리스트 호츨, paged 호출방식
  Future<Result<ChannelPagedResponse>> loadPagedChannels(
      DocumentSnapshot? lastDocument);

  // 채널정보 호출, id값을 기준으로
  Future<Result<ChannelModel>> loadChannelById(String channelId);

  // 특정 채널의 콘텐츠 리스트 호출 (페이징 적용)
  Future<Result<ChannelContentList>> loadPagedChannelContents(
      ChannelContentsRequest request);

  // 특정 채널의 콘텐츠 리스트 호출 (기본 10개)
  Future<Result<List<ContentPosterShell>>> loadChannelContentsWithLimit(
      {required String channelId, required String currentContentId});
}
