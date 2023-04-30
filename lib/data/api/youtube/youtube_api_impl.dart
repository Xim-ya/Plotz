import 'package:soon_sak/data/mixin/youtube_meta_data_helper_mixin.dart';
import 'package:soon_sak/utilities/index.dart';


class YoutubeApiImpl with YoutubeMetaDataHelper implements YoutubeApi {

  @override
  Future<CommentsList?> loadVideoComments(String videoId) async {
    final video = await getVideoRes(videoId);
    final comments = await videoClient.commentsClient.getComments(video);
    return comments;
  }
}
