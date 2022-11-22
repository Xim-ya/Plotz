import 'package:uppercut_fantube/domain/model/youtube/youtube_video_content_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class YoutubeRepositoryImpl extends YoutubeRepository {
  /* 유튜브 컨텐츠 댓글 리스트 호출 */
  @override
  Future<Result<CommentsList?>> loadContentCommentList(String videoId) async {
    try {
      // 유튜브 댓글
      final video = await YoutubeMetaData.yt.videos.get(videoId);
      final commentList =
          await YoutubeMetaData.yt.videos.commentsClient.getComments(video);
      return Result.success(commentList);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /* 유튜브 비디오 컨텐츠 정보 (좋아요 수 / 조회수 / 업로드 일자)*/
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

/* 유튜브 비디오 정보 호출 (좋아요 수, 조회수, 비디오 등록일) */
}
