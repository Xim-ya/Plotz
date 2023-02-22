import 'package:dio/dio.dart';
import 'package:soon_sak/data/api/staticContent/response/content_key_response.dart';

abstract class NewStaticContentApi {
  // 배터 컨텐츠 리스트
  Future<Response<dynamic>> loadBannerContents();

  // Top10 컨텐츠 리스트
  Future<Response<dynamic>> loadTopTenContents();

  // 카테고리 Collection 리스트
  Future<Response<dynamic>> loadCategoryContentCollections();

  // Static Content 키 리스트
  Future<ContentKeyResponse> loadStaticContentKeys();

}