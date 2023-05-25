import 'package:soon_sak/domain/model/content/home/top_positioned_collection.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class StaticContentRepository {
  // 홈 상단 배너 컨텐츠 정보 호출
  Future<Result<BannerModel>> loadBannerContentList();

  // Top 10 컨텐츠 정보 호출
  Future<Result<TopTenContentsModel>> loadTopTenContent();

  // 고정 컨텐츠 리스트 키 값 호출
  Future<Result<StaticContentKeys>> loadStaticContentKeys();

  // 카테고리 컨텐츠 모음 정보 호출
  Future<Result<CategoryContentCollection>> loadCategoryContentCollection(
      int page);

  // 상단 노출 Collection 리스트
  Future<Result<TopPositionedCollection>> loadTopPositionedCollection();

  // static StaticContentRepository get to => Get.find();
}
