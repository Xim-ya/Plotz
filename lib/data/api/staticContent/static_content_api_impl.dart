import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:soon_sak/app/environment/environment.dart';
import 'package:soon_sak/data/api/staticContent/response/content_key_response.dart';
import 'package:soon_sak/data/api/staticContent/static_content_api.dart';

class StaticContentApiImpl implements StaticContentApi {
  final Dio _dio;
  final String baseUrl =
      'https://${Environment.baseUrl}-default-rtdb.asia-southeast1.firebasedatabase.app';

  StaticContentApiImpl(this._dio);

  @override
  Future<Response<dynamic>> loadBannerContents() async =>
      _dio.get('$baseUrl/banner.json');

  @override
  Future<Response<dynamic>> loadCategoryContentCollections(int index) async =>
      _dio.get('$baseUrl/categoryContent.json?page=$index');

  @override
  Future<Response<dynamic>> loadTopTenContents() =>
      _dio.get('$baseUrl/topTenContent.json');

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() async {
    final response = await _dio.get('$baseUrl/contentKey.json');
    final json = jsonDecode(response.toString());
    return ContentKeyResponse.fromJson(json);
  }

  @override
  Future<Response<dynamic>> loadTopPositionedCollection() =>
      _dio.get('$baseUrl/topPositionedCollection.json');

  @override
  Future<Response> loadNewlyAddedContents() async =>
      _dio.get('$baseUrl/newlyAddedContent.json');
}
