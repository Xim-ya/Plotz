import 'package:uppercut_fantube/domain/model/content/content_main_info.dart';
import 'package:uppercut_fantube/utilities/result.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

abstract class ContentRepository {
  Future<Result<ContentMainInfo>> loadContentMainInfo();
  Future<Result<CommentsList?>> loadContentCommentList(String videoId);
}
