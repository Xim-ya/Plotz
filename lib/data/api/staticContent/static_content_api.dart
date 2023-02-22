import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soon_sak/data/api/staticContent/response/json_string_response.dart';
import 'package:soon_sak/utilities/index.dart';

part 'static_content_api.g.dart';

@RestApi(
    baseUrl:
        'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app')
abstract class StaticContentApi {
  factory StaticContentApi(Dio dio) = _StaticContentApi;

  @GET('/contentKey.json')
  Future<ContentKeyResponse> loadStaticContentKeys();

  @GET('/banner.json')
  Future<JsonResponse> loadBannerContent();

  @GET('/topTenContent.json')
  Future<JsonResponse> loadTopTenContent();

  @GET('/categoryContent.json')
  Future<JsonResponse> loadCategoryContentCollection();
}
