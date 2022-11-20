import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_api.g.dart';

// https://api.themoviedb.org/3/tv/111800?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1

// 인기 드라마 컨텐츠
// "https://api.themoviedb.org/3/tv/popular?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1";

// "https://api.themoviedb.org/3/movie/438148/similar?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1"

// 인기 영화 컨텐츠
// "https://api.themoviedb.org/3/movie/popular?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1"
// https://api.themoviedb.org/3/search/movie?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1&query=닥터


@RestApi(baseUrl: 'https://api.themoviedb.org/3')
abstract class TmdbApi {
  factory TmdbApi(Dio dio, {String baseUrl}) = _TmdbApi;
  /*** New One ***/
  @GET('/tv/{tvId}?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1')
  Future<TmdbTvDetailResponse> loadTmdbDetailResponse(@Path('tvId') int tvId);




  // @GET(
  //     '/movie/{movieId}/similar?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1')
  // Future<TmdbMovieResponse> loadSimilarMovieList(@Path('movieId') int movieId);
  /*** Old One ***/
  //`인기 영화` 호출
  // @GET(
  //     '/movie/popular?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1')
  // Future<TmdbMovieResponse> loadPopularMovie();
  //
  // // `인기 드라마` 호출
  // @GET(
  //     "/tv/popular?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1")
  // Future<TmdbPopularDramaResponse> loadPopularDrama();
  // // https://api.themoviedb.org/3/movie/453395/videos?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1
  //
  // // 영화 `비디오 정보` 호출 (예고판 키값 등등)
  // @GET(
  //     "/movie/{movieId}/videos?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1")
  // Future<TmdbMovieVideoInfoResponse> loadTmdbMovieVideoInfo(
  //     @Path("movieId") int movieId);
  //
  // // https://api.themoviedb.org/3/movie/${453395}/credits?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1
  // // `영화 크래딧` 정보 호출 (출연진 정보 등등)
  // @GET(
  //     "/movie/{movieId}/credits?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1")
  // Future<TmdbMovieCreditResponse> loadMovieCreditInfo(
  //     @Path("movieId") int movieId);
  //
  // @GET(
  //     "/movie/{movieId}?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1")
  // Future<TmdbMovieDetailInfoResponse> loadMovieDetailInfo(
  //     @Path('movieId') int movieId);
  //
  // // `드라마 크래딧` 정보 호출 (출연진 정보 등등)
  // @GET(
  //     '/tv/{dramaId}/credits?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1')
  // Future<TmdbDramaCreditResponse> loadDramaCreditInfo(
  //     @Path("dramaId") int dramaId);
  //
  // // '장르'로 영화 리스트 정보 호출
  // @GET(
  //     '/discover/movie?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page={page}&with_genres={genreId}')
  // Future<TmdbGenreMovieListResponse> loadMovieListByGenreResponse(
  //     @Path('genreId') int genreId, @Path('page') int page);
  //
  // @GET(
  //     '/search/movie?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1&query={query}')
  // Future<TmdbMovieResponse> loadMovieSearchList(@Path('query') String query);
  //
  // // 유사 영화 컨텐츠 검색
  // // https://api.themoviedb.org/3/movie/{movieId}/similar?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1
  // // searchAnndSimilarContentList

}

// https://api.themoviedb.org/3/search/movie?api_key=b40235ce96defc556ca26d48159f5f13&language=ko-KR&page=1&query=닥터
