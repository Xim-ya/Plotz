import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uppercut_fantube/data/dto/staticContent/response/banner_response.dart';

part 'static_content_api.g.dart';

@RestApi(
    baseUrl:
        'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app')
abstract class StaticContentApi {
  factory StaticContentApi(Dio dio) = _StaticContentApi;

  @GET('/banner.json')
  Future<BannerResponse> loadBannerContentList();
}
