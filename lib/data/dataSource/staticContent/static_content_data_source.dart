import 'package:soon_sak/data/index.dart';

import 'package:soon_sak/utilities/index.dart';

abstract class StaticContentDataSource {
  // 홈 상단 배너 컨텐츠 정보 호출
  Future<BannerResponse> loadBannerContents();

  // Top 10 컨텐츠 정보 호출
  Future<TopTenContentResponse> loadTopTenContents();

  // 고정 컨텐츠 key 값 호출
  Future<ContentKeyResponse> loadStaticContentKeys();

  // NEW : 카테고리 컨텐츠 모음 정보 호출
  Future<CategoryContentCollectionResponse> loadCategoryContentCollection(
      int page);

  // 상단 노출 Collection 리스트
  Future<TopPositionedCollectionResponse> loadTopPositionedCollection();
}
