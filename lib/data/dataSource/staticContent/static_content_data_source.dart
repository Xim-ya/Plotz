import 'package:soon_sak/utilities/index.dart';


abstract class StaticContentDataSource with FireStoreErrorHandlerMixin {
  // 홈 상단 배너 컨텐츠 정보 호출
  Future<BannerResponse> loadBannerContents();

  // Top 10 컨텐츠 정보 호출
  Future<TopTenContentResponse> loadTopTenContents();

  // 고정 컨텐츠 key 값 호출
  Future<ContentKeyResponse> loadStaticContentKeys();

  // 카테고리 컨텐츠 모음 정보 호출
  Future<CategoryContentCollectionResponse> loadCategoryContentCollection();



}
