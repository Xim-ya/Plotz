import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_content_credit_response.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_content_image_response.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_movie_content_list_wrapped_response.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_movie_detail_response.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_tv_content_list_wrapped_response.dart';
import 'package:soon_sak/data/api/tmdb/response/newResponse/tmdb_tv_detail_response.dart';

part 'tmdb_api.g.dart';


@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class TmdbApi {
  factory TmdbApi(Dio dio, {String baseUrl}) = _TmdbApi;

  // 'tv' 컨텐츠 상세 정보
  @GET('/tv/{tvId}')
  Future<TmdbTvDetailResponse> loadTmdbMovieDetailResponse({
    @Path('tvId') required int tvId,
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
  });

  // 'tv' 컨텐츠 credit 정보
  @GET('/tv/{tvId}/credits')
  Future<TmdbContentCreditResponse> loadTvCreditInfo({
    @Path('tvId') required int tvId,
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
  });

  // 'tv' 컨텐츠 이미지 리스트
  @GET('/tv/{tvId}/images')
  Future<TmdbImagesResponse> loadTvImages(
      {@Path('tvId') required int tvId,
      @Query('api_key') required String apiKey});


  // 'tv' 컨텐츠 검색 결과
  @GET('/search/tv')
  Future<TmdbTvContentListWrappedResponse> loadSearchedTvContentList({
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('query') required String query,
  });

  // 'movie' 컨텐츠 상세 정보
  @GET('/movie/{movieId}')
  Future<TmdbMovieDetailResponse> loadTmdbMovieDetailInfoResponse({
    @Path('movieId') required int movieId,
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
  });

  // 'movie' 컨텐츠 credit 정보
  @GET('/movie/{movieId}/credits')
  Future<TmdbContentCreditResponse> loadMovieCreditInfo({
    @Path('movieId') required int movieId,
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
  });

  // 'movie' 컨텐츠 이미지 리스트
  @GET('/movie/{movieId}/images')
  Future<TmdbImagesResponse> loadMovieImages({
    @Path('movieId') required int movieId,
    @Query('api_key') required String apiKey,
  });

  // 'movie' 컨텐츠 검색 결과
  @GET('/search/movie')
  Future<TmdbMovieContentListWrappedResponse> loadSearchedMovieContentList({
    @Query('api_key') required String apiKey,
    @Query('language') required String language,
    @Query('page') required int page,
    @Query('query') required String query,
  });
}
