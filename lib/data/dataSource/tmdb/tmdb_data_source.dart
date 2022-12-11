import 'package:uppercut_fantube/data/api/tmdb/response/newResponse/tmdb_tv_credit_response.dart';
import 'package:uppercut_fantube/data/api/tmdb/response/newResponse/tmdb_tv_images_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

abstract class TmdbDataSource {
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(int tvId);

  Future<TmdbTveCreditResponse> loadTmdbTvCastInfoResponse(int tvId);

  Future<TmdbTvImagesResponse> loadTmdbTvIContentImages(int tvId);
}