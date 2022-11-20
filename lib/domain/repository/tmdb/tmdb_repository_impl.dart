import 'package:uppercut_fantube/data/dataSource/tmdb/tmdb_data_source.dart';
import 'package:uppercut_fantube/domain/model/content/content_description_info.dart';
import 'package:uppercut_fantube/domain/repository/tmdb/tmdb_repository.dart';
import 'package:uppercut_fantube/utilities/result.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  TmdbRepositoryImpl(this._dataSource);

  final TmdbDataSource _dataSource;

  // TV 드라마 상세 정보 호출 - (컨텐츠 상세 페이지)
  @override
  Future<Result<ContentDescriptionInfo>> loadTmdbDetailResponse(
      int tvId) async {
    try {
      final response = await _dataSource.loadTmdbDetailResponse(tvId);
      return Result.success(ContentDescriptionInfo.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
