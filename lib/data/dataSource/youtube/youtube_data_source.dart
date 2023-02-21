import 'package:soon_sak/utilities/index.dart';

abstract class YoutubeDataSource {
  // 비디오 댓글 리스트
  Future<CommentsList?> loadVideoComments(String videoId);
}