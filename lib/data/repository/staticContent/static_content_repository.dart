import 'package:uppercut_fantube/domain/model/staticContent/banner.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class StaticContentRepository {
  Future<Result<BannerModel>> loadBannerContentList();



  static StaticContentRepository get to => Get.find();
}