import 'dart:convert';
import 'package:uppercut_fantube/data/dto/staticContent/response/content_key_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';
import 'package:http/http.dart' as http;

class StaticContentDataSourceImpl extends StaticContentDataSource {
  StaticContentDataSourceImpl(this._api);

  final StaticContentApi _api;

  final String baseUrl =
      'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<BannerResponse> loadBannerContents() async {
    final response = await http.get(Uri.parse('$baseUrl/banner.json'));
    final jsonText = response.body;

    // LocalStorage에 받아온 response의 boy(jsonText) 저장
    await LocalStorageService.to.saveData(fieldName: 'banner', data: jsonText);
    final data = jsonDecode(jsonText);

    return BannerResponse.fromJson(data);
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    final response = await http.get(Uri.parse('$baseUrl/topTenContent.json'));
    final jsonText = response.body;

    // LocalStorage에 받아온 response의 boy(jsonText) 저장
    await LocalStorageService.to.saveData(fieldName: 'topTen', data: jsonText);
    final data = jsonDecode(jsonText);

    return TopTenContentResponse.fromJson(data);
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() {
    return loadResponseOrThrow(() => _api.loadStaticContentKeys());
  }

  @override
  Future<CategoryContentCollectionResponse>
      loadCategoryContentCollection() async {
    final response = await http.get(Uri.parse('$baseUrl/categoryContent.json'));
    final jsonText = response.body;
    final data = jsonDecode(jsonText);

    return CategoryContentCollectionResponse.fromJson(data);
  }
}
