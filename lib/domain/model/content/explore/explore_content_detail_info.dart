import 'package:soon_sak/data/index.dart';

class ExploreContentDetailInfo {
  final String? posterImg; // 포스터 이미지
  final String title; // 컨텐츠 제목
  final String? releaseDate; // 개봉일

  ExploreContentDetailInfo({
    required this.posterImg,
    required this.title,
    required this.releaseDate,
  }); // 컨텐츠 타입

  // 영화
  factory ExploreContentDetailInfo.fromMovieResponse(
    TmdbMovieDetailResponse response,
  ) {
    /// TMDB API에서 형식이 이상 firstAirDate 필드가 넘어옴
    /// 검증 로직이 필요
    String? verifiedReleaseDate() {
      if (response.release_date == null) {
        return null;
      }
      if (response.release_date!.contains('-')) {
        return response.release_date;
      } else if (response.release_date == 'null') {
        return response.release_date;
      } else {
        return null;
      }
    }

    return ExploreContentDetailInfo(
      posterImg: response.poster_path ?? response.backdrop_path,
      title: response.title,
      releaseDate: verifiedReleaseDate(),
    );
  }

  // 드라마
  factory ExploreContentDetailInfo.fromTvResponse(
    TmdbTvDetailResponse response,
  ) {
    /// TMDB API에서 형식이 이상 firstAirDate 필드가 넘어옴
    /// 검증 로직이 필요
    String? verifyReleaseDate() {
      if (response.first_air_date == null) {
        return null;
      }
      if (response.first_air_date!.contains('-')) {
        return response.first_air_date;
      } else if (response.first_air_date == 'null') {
        return response.first_air_date;
      } else {
        return null;
      }
    }

    return ExploreContentDetailInfo(
      posterImg: response.poster_path ?? response.backdrop_path,
      title: response.name,
      releaseDate: verifyReleaseDate(),
    );
  }
}
