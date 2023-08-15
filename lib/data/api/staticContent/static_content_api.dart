import 'package:dio/dio.dart';
import 'package:soon_sak/data/api/staticContent/response/content_key_response.dart';

/** Created By Ximya - 2023.02.22
 *  정적 컨텐츠 리스트를 호출하는 Api module
 *  몇몇 api response는 [_dataSource]레이어에서
 *  캐싱 처리를 위해 body 데이터 타입으로 넘겨주어야함. [Response<dynamic>]
 *
 * */

abstract class StaticContentApi {
  // 배너 컨텐츠 리스트
  Future<Response<dynamic>> loadBannerContents();

  // Top10 컨텐츠 리스트
  Future<Response<dynamic>> loadTopTenContents();

  // 최근 업로드된 콘텐츠 리스트
  Future<Response<dynamic>> loadNewlyAddedContents();

  // 카테고리 Collection 리스트
  Future<Response<dynamic>> loadCategoryContentCollections(int index);

  // 상단 노출 Collection 리스트
  Future<Response<dynamic>> loadTopPositionedCollection();

  // Static Content 키 리스트
  Future<ContentKeyResponse> loadStaticContentKeys();
}
