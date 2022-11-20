import 'package:uppercut_fantube/data/dataSource/tmdb/tmdb_data_source.dart';
import 'package:uppercut_fantube/data/api/tmdb/response/newResponse/tmdb_tv_detail_response.dart';
import 'package:uppercut_fantube/data/api/tmdb/tmdb_api.dart';
import 'package:uppercut_fantube/utilities/api_error_handler_mixin.dart';

class TmdbDataSourceImpl with ApiErrorHandlerMixin implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  @override
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(int tvId) async =>
      await _api.loadTmdbDetailResponse(tvId);
}
