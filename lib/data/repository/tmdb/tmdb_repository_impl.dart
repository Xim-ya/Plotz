import 'package:uppercut_fantube/domain/model/content/tv_content_credit_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';


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


  // TV 드라마 'credit' 정보 호출
  @override
  Future<Result<List<ContentCreditInfo>>> loadTvCreditInfo(int tvId) async{
    try {
      final response = await _dataSource.loadTmdbTvCastInfoResponse(tvId);
      return Result.success(response.cast.map((e) => ContentCreditInfo.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
