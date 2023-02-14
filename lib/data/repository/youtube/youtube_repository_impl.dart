import 'package:soon_sak/domain/model/youtube/youtube_channel_info.dart';
import 'package:soon_sak/utilities/index.dart';

class YoutubeRepositoryImpl extends YoutubeRepository {
  /* 유튜브 컨텐츠 댓글 리스트 호출 */
  @override
  Future<Result<List<YoutubeContentComment>>> loadContentCommentList(
      String videoId) async {
    try {
      // 유튜브 댓글
      final video = await YoutubeMetaData.yt.videos.get(videoId);
      final commentList =
          await YoutubeMetaData.yt.videos.commentsClient.getComments(video);
      final result =
          commentList!.map(YoutubeContentComment.fromResponse).toList();
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /* 유튜브 비디오 컨텐츠 정보 (좋아요 수 / 조회수 / 업로드 일자...)*/
  @override
  Future<Result<YoutubeVideoContentInfo>> loadYoutubeVideoContentInfo(
      String videoId) async {
    try {
      final video = await YoutubeMetaData.yt.videos.get(videoId);
      return Result.success(YoutubeVideoContentInfo.fromResponse(video));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /* 유튜브 채널 정보 호출 */
  @override
  Future<Result<YoutubeChannelInfo>> loadYoutubeChannelInfo(
      String videoId) async {
    try {
      final channelRes = await YoutubeMetaData.yt.channels.getByVideo(videoId);
      final channelDetailRes =
          await YoutubeMetaData.yt.channels.getAboutPage(channelRes.id);
      return Result.success(
        YoutubeChannelInfo.fromResponse(
          response: channelRes,
          detailResponse: channelDetailRes,
        ),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

/* 유튜브 비디오 정보 호출 (좋아요 수, 조회수, 비디오 등록일) */
}
