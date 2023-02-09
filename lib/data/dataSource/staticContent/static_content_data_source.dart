import 'package:uppercut_fantube/data/dto/staticContent/response/banner_response.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_error_handler_mixin.dart';

abstract class StaticContentDataSource with FireStoreErrorHandlerMixin {

  // 홈 상단 배너 컨텐츠 리스트 정보 호출
  Future<BannerResponse> loadBannerContentList();
}
