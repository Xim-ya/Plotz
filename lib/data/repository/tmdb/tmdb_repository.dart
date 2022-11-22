import 'package:uppercut_fantube/utilities/index.dart';


abstract class TmdbRepository {
  Future<Result<ContentDescriptionInfo>> loadTmdbDetailResponse(int tvId);


  static TmdbRepository get to => Get.find();
}
