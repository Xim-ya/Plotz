
import 'package:soon_sak/data/dataSource/youtube/youtube_data_source.dart';
import 'package:soon_sak/utilities/index.dart';

class YoutubeRepositoryImpl extends YoutubeRepository {
  YoutubeRepositoryImpl(this._dataSource);
  final YoutubeDataSource _dataSource;




  /* 유튜브 컨텐츠 댓글 리스트 호출 */
  @override
  Future<Result<List<YoutubeContentComment>>> loadContentCommentList(
      String videoId) async {
    try {
      // 유튜브 댓글
      final response = await _dataSource.loadVideoComments(videoId);
      final result= response?.map((e) => YoutubeContentComment.fromResponse(e)).toList();
      return Result.success(result ?? []);
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
