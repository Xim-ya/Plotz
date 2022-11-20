import 'package:get/get.dart';
import 'package:uppercut_fantube/domain/model/content/content_description_info.dart';
import 'package:uppercut_fantube/utilities/result.dart';

abstract class TmdbRepository {
  Future<Result<ContentDescriptionInfo>> loadTmdbDetailResponse(int tvId);


  static TmdbRepository get to => Get.find();
}
