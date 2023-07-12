import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class TmdbRepositoryImpl implements TmdbRepository {
  TmdbRepositoryImpl(this._dataSource);

  final TmdbDataSource _dataSource;

  // TV 드라마 상세 정보 호출 - (컨텐츠 상세 페이지)
  @override
  Future<Result<ContentDetailInfo>> loadTvInfo(int tvId) async {
    try {
      final response = await _dataSource.loadTvContentInfo(tvId);
      return Result.success(ContentDetailInfo.fromTvDetailResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // TV 드라마 'credit' 정보 호출
  @override
  Future<Result<List<ContentCreditInfo>>> loadTvCreditInfo(int tvId) async {
    try {
      final response = await _dataSource.loadTmdbTvCastInfo(tvId);
      return Result.success(
        response.cast.map(ContentCreditInfo.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // TV 드라마 image url 리스트 호출
  @override
  Future<Result<List<String>>> loadTvContentImages(int tvId) async {
    try {
      final response = await _dataSource.loadTmdbTvIContentImages(tvId);
      return Result.success(
        response.backdrops.map((e) => e.file_path).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ContentDetailInfo>> loadMovieInfo(int movieId) async {
    try {
      final response = await _dataSource.loadMovieInfo(movieId);
      return Result.success(
        ContentDetailInfo.fromMovieDetailResponse(response),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ContentCreditInfo>>> loadMovieCredits(
    int movieId,
  ) async {
    try {
      final response =
          await _dataSource.loadTmdbMovieCreditInfo(movieId);
      return Result.success(
        response.cast.map(ContentCreditInfo.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<String>>> loadMovieContentImages(int movieId) async {
    try {
      final response = await _dataSource.loadTmdbMovieIContentImages(movieId);
      return Result.success(
        response.backdrops.map((e) => e.file_path).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // 'TV' 컨텐츠 검색 결과 리스트
  @override
  Future<Result<SearchContentModel>> loadSearchedTvContents({
    required String query,
    required int page,
  }) async {
    try {
      final response =
          await _dataSource.loadSearchedTvContents(query: query, page: page);
      return Result.success(SearchContentModel.fromTvResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // 'Movie' 컨텐츠 검색 결과 리스트
  @override
  Future<Result<SearchContentModel>> loadSearchedMovieContents({
    required String query,
    required int page,
  }) async {
    try {
      final response = await _dataSource.loadSearchedMovieContents(
        query: query,
        page: page,
      );
      return Result.success(SearchContentModel.fromMovieResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
