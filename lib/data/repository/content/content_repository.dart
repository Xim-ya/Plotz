import 'package:uppercut_fantube/utilities/index.dart';


abstract class ContentRepository {
  Future<Result<ContentMainInfo>> loadContentMainInfo();


  Future<Result<CommentsList?>> loadContentCommentList(String videoId);

  Future<Result<List<TopExposedContent>>> loadTopExposedContent();


  static ContentRepository get to => Get.find();
}
