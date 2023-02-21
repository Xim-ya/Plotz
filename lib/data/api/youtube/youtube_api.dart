import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class YoutubeApi {
  // 비디오 댓글 리스트
  Future<CommentsList?> loadVideoComments(String videoId);
}
