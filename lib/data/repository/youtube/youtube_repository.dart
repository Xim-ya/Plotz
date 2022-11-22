import 'package:uppercut_fantube/domain/model/youtube/youtube_video_content_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/* Created By Ximya - 2022.11.22
*  [YoutubeAPI] [YoutubeExplore] API 데이터를 호출을 관리하는 Repository
* */

abstract class YoutubeRepository {
  Future<Result<CommentsList?>> loadContentCommentList(String videoId);

  Future<Result<YoutubeVideoContentInfo>> loadYoutubeVideoContentInfo(String videoId);

  static YoutubeRepository get to => Get.find();
}