import 'package:uppercut_fantube/utilities/index.dart';

abstract class TmdbDataSource {
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(int tvId);

  Future<TmdbTveCreditResponse> loadTmdbTvCastInfoResponse(int tvId);

  Future<TmdbTvImagesResponse> loadTmdbTvIContentImages(int tvId);
}