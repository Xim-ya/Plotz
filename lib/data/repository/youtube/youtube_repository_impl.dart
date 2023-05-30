import 'package:soon_sak/data/mixin/isolate_helper_mixin.dart';
import 'package:soon_sak/utilities/index.dart';

class YoutubeRepositoryImpl extends YoutubeRepository with IsolateHelperMixin {
  YoutubeRepositoryImpl(this._dataSource);

  final YoutubeDataSource _dataSource;

  /* 유튜브 컨텐츠 댓글 리스트 호출 */
  @override
  Future<Result<List<YoutubeContentComment>>> loadContentCommentList(
    String videoId,
  ) async {
    try {
      // 유튜브 댓글
      final response = await _dataSource.loadVideoComments(videoId);
      final result = response?.map(YoutubeContentComment.fromResponse).toList();
      return Result.success(result ?? []);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  /* 유튜브 비디오 컨텐츠 정보 (좋아요 수 / 조회수 / 업로드 일자...)*/
  // ISOLATE 적용

  // @override
  // Future<Result<YoutubeVideoContentInfo>> loadYoutubeVideoContentInfo(
  //   String videoId,
  // ) async {
  //   final response = await YoutubeMetaData.yt.videos.get(videoId);
  //   return Result.success(YoutubeVideoContentInfo.fromResponse(response));
  // }

  @override
  Future<Result<YoutubeVideoContentInfo>> loadYoutubeVideoContentInfo(
    String videoId,
  ) async {
    try {
      return await loadWithIsolate(() async {
        try {
          final response = await YoutubeMetaData.yt.videos.get(videoId);
          return Result.success(YoutubeVideoContentInfo.fromResponse(response));
        } on Exception catch (e) {
          return Result.failure(e);
        }
      });
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
