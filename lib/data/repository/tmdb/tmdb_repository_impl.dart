import 'package:soon_sak/domain/model/content/search/search_content_model.dart';
import 'package:soon_sak/utilities/index.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  TmdbRepositoryImpl(this._dataSource);

  final TmdbDataSource _dataSource;

  // TV 드라마 상세 정보 호출 - (컨텐츠 상세 페이지)
  @override
  Future<Result<ContentDetailInfo>> loadTmdbTvDetailResponse(int tvId) async {
    try {
      final response = await _dataSource.loadTmdbTvDetailResponse(tvId);
      return Result.success(ContentDetailInfo.fromTvDetailResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // TV 드라마 'credit' 정보 호출
  @override
  Future<Result<List<ContentCreditInfo>>> loadTvCreditInfo(int tvId) async {
    try {
      final response = await _dataSource.loadTmdbTvCastInfoResponse(tvId);
      return Result.success(
          response.cast.map((e) => ContentCreditInfo.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // TV 드라마 image url 리스트 호출
  @override
  Future<Result<List<String>>> loadTvImgUrlList(int tvId) async {
    try {
      final response = await _dataSource.loadTmdbTvIContentImages(tvId);
      return Result.success(
          response.backdrops.map((e) => e.file_path).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ContentDetailInfo>> loadTmdbMovieDetailInfo(int movieId) async {
    try {
      final response = await _dataSource.loadTmdbMovieDetailResponse(movieId);
      return Result.success(
          ContentDetailInfo.fromMovieDetailResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ContentCreditInfo>>> loadMovieCreditInfo(
      int movieId) async {
    try {
      final response =
          await _dataSource.loadTmdbMovieCreditInfoResponse(movieId);
      return Result.success(
          response.cast.map((e) => ContentCreditInfo.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> loadMovieImgUrlList(int movieId) async {
    try {
      final response = await _dataSource.loadTmdbMovieIContentImages(movieId);
      return Result.success(
          response.backdrops.map((e) => e.file_path).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // 'TV' 컨텐츠 검색 결과 리스트
  @override
  Future<Result<SearchContentModel>> loadSearchedTvContentList(
      {required String query, required int page}) async {
    try {
      final response =
          await _dataSource.loadSearchedTvContentList(query: query, page: page);
      return Result.success(SearchContentModel.fromTvResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // 'Movie' 컨텐츠 검색 결과 리스트
  @override
  Future<Result<SearchContentModel>> loadSearchedMovieContentList(
      {required String query, required int page}) async {
    try {
      final response = await _dataSource.loadSearchedMovieContentList(
          query: query, page: page);
      return Result.success(SearchContentModel.fromMovieResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
