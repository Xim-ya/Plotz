import 'dart:convert';
import 'package:soon_sak/domain/service/local_storage.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:http/http.dart' as http;

class StaticContentDataSourceImpl implements StaticContentDataSource {
  StaticContentDataSourceImpl(this._api, this._localStorage);

  final StaticContentApi _api;
  final LocalStorageService _localStorage;

  final String baseUrl =
      'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<BannerResponse> loadBannerContents() async {
    final response = await http.get(Uri.parse('$baseUrl/banner.json'));
    final jsonText = response.body;

    // LocalStorage에 받아온 response의 boy(jsonText) 저장
    await _localStorage.saveData(key: 'banner', data: jsonText);
    final data = jsonDecode(jsonText);

    return BannerResponse.fromJson(data);
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    final response = await http.get(Uri.parse('$baseUrl/topTenContent.json'));
    final jsonText = response.body;

    // LocalStorage에 받아온 response의 boy(jsonText) 저장
    await _localStorage.saveData(key: 'topTen', data: jsonText);
    final data = jsonDecode(jsonText);

    return TopTenContentResponse.fromJson(data);
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() =>
      _api.loadStaticContentKeys();

  @override
  Future<CategoryContentCollectionResponse>
      loadCategoryContentCollection() async {
    final response = await http.get(Uri.parse('$baseUrl/categoryContent.json'));
    final jsonText = response.body;

    // LocalStorage에 받아온 response의 boy(jsonText) 저장
    await _localStorage.saveData(key: 'categoryCollection', data: jsonText);
    final data = jsonDecode(jsonText);

    return CategoryContentCollectionResponse.fromJson(data);
  }
}
