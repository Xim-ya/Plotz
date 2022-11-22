import 'package:uppercut_fantube/utilities/index.dart';

class TmdbDataSourceImpl with ApiErrorHandlerMixin implements TmdbDataSource {
  TmdbDataSourceImpl(this._api);

  final TmdbApi _api;

  @override
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(int tvId) async =>
      await _api.loadTmdbDetailResponse(tvId);
}
