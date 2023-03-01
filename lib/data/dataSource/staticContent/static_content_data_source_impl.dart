import 'dart:convert';
import 'package:soon_sak/utilities/index.dart';


class StaticContentDataSourceImpl implements StaticContentDataSource {
  StaticContentDataSourceImpl(this._localStorage, this._api);

  final StaticContentApi _api;
  final LocalStorageService _localStorage;

  @override
  Future<BannerResponse> loadBannerContents() async {
    final response = await _api.loadBannerContents();
    await _localStorage.saveData(fieldName: 'banner', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return BannerResponse.fromJson(json);
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    final response = await _api.loadTopTenContents();
    await _localStorage.saveData(fieldName: 'topTen', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return TopTenContentResponse.fromJson(json);
  }


  @override
  Future<CategoryContentCollectionResponse>
      loadCategoryContentCollection() async {

    final response = await _api.loadCategoryContentCollections();
    await _localStorage.saveData(fieldName: 'categoryCollection', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return CategoryContentCollectionResponse.fromJson(json);
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() =>
      _api.loadStaticContentKeys();
}
