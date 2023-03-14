import 'dart:convert';
import 'package:soon_sak/utilities/index.dart';

class StaticContentDataSourceImpl implements StaticContentDataSource {
  StaticContentDataSourceImpl(this._localStorage, this._api);

  final StaticContentApi _api;
  final LocalStorageService _localStorage;

  @override
  Future<BannerResponse> loadBannerContents() async {
    final response = await _api.loadBannerContents();
    await _localStorage.saveData(
        fieldName: 'banner', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return BannerResponse.fromJson(json);
  }

  @override
  Future<TopTenContentResponse> loadTopTenContents() async {
    final response = await _api.loadTopTenContents();
    await _localStorage.saveData(
        fieldName: 'topTen', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    print('aim - 4 --> ${jsonDecode(response.toString())}');

    return TopTenContentResponse.fromJson(json);
  }

  @override
  Future<CategoryContentCollectionResponse>
      loadCategoryContentCollection() async {
    final response = await _api.loadCategoryContentCollections(1);
    await _localStorage.saveData(
        fieldName: 'categoryCollection1',
        data: jsonEncode(response.data['categoryContent']['page1']));
    final json = response.data['categoryContent']['page1'];

    return CategoryContentCollectionResponse.fromJson(json);
  }

  @override
  Future<CategoryContentCollectionResponse> newLoadCategoryContentCollection(
      int page) async {
    final Object? localData =
        await _localStorage.getData(fieldName: 'categoryCollection$page');

    if (localData.hasData) {
      final json = jsonDecode(localData.toString());
      return CategoryContentCollectionResponse.fromJson(json);
    } else {
      final response = await _api.loadCategoryContentCollections(page);
      await _localStorage.saveData(
          fieldName: 'categoryCollection1',
          data: jsonEncode(response.data['categoryContent']['page1']));
      final json = response.data['categoryContent']['page1'];
      return CategoryContentCollectionResponse.fromJson(json);
    }
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() =>
      _api.loadStaticContentKeys();
}
