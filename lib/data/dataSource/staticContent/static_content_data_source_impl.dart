import 'dart:convert';
import 'package:soon_sak/data/api/staticContent/response/newly_added_content_response.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class StaticContentDataSourceImpl implements StaticContentDataSource {
  StaticContentDataSourceImpl(
      {required LocalStorageService localStorage,
      required StaticContentApi api})
      : _localStorage = localStorage,
        _api = api;

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

    return TopTenContentResponse.fromJson(json);
  }

  @override
  Future<CategoryContentCollectionResponse> loadCategoryContentCollection(
      int page) async {
    final Object? localData =
        await _localStorage.getData(fieldName: 'categoryCollection$page');

    /// 조건 : LocalStorage에 데이터가 존재한다면
    /// Api call을 하지 않고 LocalStorage에서 데이터를 가져옴
    if (localData.hasData) {
      final json = jsonDecode(localData.toString());
      return CategoryContentCollectionResponse.fromJson(json);
    }

    /// LocalStorage에 데이터가 없다면
    /// 서버로부터 데이터를 가져옴
    else {
      final response = await _api.loadCategoryContentCollections(page);
      await _localStorage.saveData(
          fieldName: 'categoryCollection$page',
          data: jsonEncode(response.data['page$page']));
      final json = response.data['page$page'];
      return CategoryContentCollectionResponse.fromJson(json);
    }
  }

  @override
  Future<ContentKeyResponse> loadStaticContentKeys() =>
      _api.loadStaticContentKeys();

  @override
  Future<TopPositionedCollectionResponse> loadTopPositionedCollection() async {
    final response = await _api.loadTopPositionedCollection();
    await _localStorage.saveData(
        fieldName: 'topPositionedCollection', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return TopPositionedCollectionResponse.fromJson(json);
  }

  @override
  Future<NewlyAddedContentResponse> loadNewlyAddedContents() async {
    final response = await _api.loadNewlyAddedContents();
    await _localStorage.saveData(
        fieldName: 'newlyAdded', data: jsonEncode(response.data));
    final json = jsonDecode(response.toString());

    return NewlyAddedContentResponse.fromJson(json);
  }
}
