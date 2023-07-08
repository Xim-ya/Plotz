import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class StaticContentRepositoryImpl extends StaticContentRepository {
  StaticContentRepositoryImpl(this._dataSource);

  final StaticContentDataSource _dataSource;

  @override
  Future<Result<BannerModel>> loadBannerContentList() async {
    try {
      final response = await _dataSource.loadBannerContents();
      return Result.success(BannerModel.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TopTenContentsModel>> loadTopTenContent() async {
    try {
      final response = await _dataSource.loadTopTenContents();
      return Result.success(TopTenContentsModel.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<StaticContentKeys>> loadStaticContentKeys() async {
    try {
      final response = await _dataSource.loadStaticContentKeys();
      return Result.success(StaticContentKeys.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<CategoryContentCollection>> loadCategoryContentCollection(
      int page) async {
    try {
      final response = await _dataSource.loadCategoryContentCollection(page);
      return Result.success(CategoryContentCollection.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<TopPositionedCollection>> loadTopPositionedCollection() async {
    try {
      final response = await _dataSource.loadTopPositionedCollection();
      return Result.success(TopPositionedCollection.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
