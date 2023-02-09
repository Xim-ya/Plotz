import 'package:uppercut_fantube/data/dataSource/staticContent/static_content_data_source.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
import 'package:uppercut_fantube/domain/model/content/home/banner.dart';
import 'package:uppercut_fantube/domain/model/content/home/static_content_keys.dart';
import 'package:uppercut_fantube/domain/model/content/home/top_ten_contents_model.dart';
import 'package:uppercut_fantube/utilities/result.dart';

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
}
