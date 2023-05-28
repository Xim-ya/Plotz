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
  Future<Response<dynamic>> loadBannerContents() async {
    final response = await _dio.get('$baseUrl/banner.json');
    return response;
  }

  @override
  Future<Response<dynamic>> loadCategoryContentCollections(int index) async {
    final response =
        await _dio.get('$baseUrl/categoryContent.json?page=$index');
    return response;
  }

  @override
  Future<Response<dynamic>> loadTopTenContents() async {
    final response = await _dio.get('$baseUrl/topTenContent.json');
    return response;
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() async {
    final response = await _dio.get('$baseUrl/contentKey.json');
    final json = jsonDecode(response.toString());
    return ContentKeyResponse.fromJson(json);
  }

  @override
  Future<Response<dynamic>> loadTopPositionedCollection() async {
    final response = await _dio.get('$baseUrl/topPositionedCollection.json');
    return response;
  }


}
