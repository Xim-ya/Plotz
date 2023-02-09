import 'package:uppercut_fantube/utilities/index.dart';


abstract class StaticContentDataSource with FireStoreErrorHandlerMixin {

  // 홈 상단 배너 컨텐츠 정보 호출
  Future<BannerResponse> loadBannerContents();

  // Top 10 컨텐츠 정보 호출
  Future<TopTenContentResponse> loadTopTenContents();

}
