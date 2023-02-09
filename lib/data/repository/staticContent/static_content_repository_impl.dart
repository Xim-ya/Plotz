import 'package:uppercut_fantube/data/dataSource/staticContent/static_content_data_source.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
import 'package:uppercut_fantube/domain/model/staticContent/banner.dart';
import 'package:uppercut_fantube/utilities/result.dart';

class StaticContentRepositoryImpl extends  StaticContentRepository {

  StaticContentRepositoryImpl(this._dataSource);

  final StaticContentDataSource _dataSource;

  @override
  Future<Result<BannerModel>> loadBannerContentList() async{
    try {
      final response = await _dataSource.loadBannerContentList();
      return Result.success(BannerModel.fromResponse(response));
    } on Exception catch(e) {
      return Result.failure(e);
    }
  }


}