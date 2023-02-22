import 'dart:convert';
import 'package:soon_sak/utilities/index.dart';


class StaticContentDataSourceImpl implements StaticContentDataSource {
  StaticContentDataSourceImpl(this._localStorage, this._newApi);

  final StaticContentApi _newApi;
  final LocalStorageService _localStorage;

  final String baseUrl =
      'https://soonsak-15350-default-rtdb.asia-southeast1.firebasedatabase.app';

  @override
  Future<BannerResponse> loadBannerContents() async {
    final response = await _newApi.loadBannerContents();
    await _localStorage.saveData(fieldName: 'banner', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return BannerResponse.fromJson(json);
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    final response = await _newApi.loadTopTenContents();
    await _localStorage.saveData(fieldName: 'topTen', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return TopTenContentResponse.fromJson(json);
  }


  @override
  Future<CategoryContentCollectionResponse>
      loadCategoryContentCollection() async {

    final response = await _newApi.loadCategoryContentCollections();
    await _localStorage.saveData(fieldName: 'categoryCollection', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return CategoryContentCollectionResponse.fromJson(json);
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() =>
      _newApi.loadStaticContentKeys();
}
