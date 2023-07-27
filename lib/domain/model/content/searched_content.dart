import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.31
 * [SearchScreen]에서 사용되는
 * 검색된 컨텐츠의 아이템 모델
 * [isRegisteredContent] [youtubeVideoId] 필드값은 late으로 선언하여
 * 핵심 정보를 load하고 이후에 받아올 수 있도록 함.
 * */

class SearchedContent {
  final int contentId;
  final String? posterImgUrl; // 컨텐츠 포스트
  final String? title;
  final String? releaseDate;
  final BehaviorSubject<RegistrationStateOld> state;
  late String? youtubeVideoId;

  SearchedContent({
    required this.contentId,
    required this.posterImgUrl,
    required this.title,
    required this.releaseDate,
    required this.state,
    this.youtubeVideoId,
  });

  /// 등록된 컨텐츠인지 판별하는 메소드.
  /// 서버에 저장된 '등록된 모든 컨텐츠' 데이터를 기반으로 등록여부를 확인함.
  /// '서버에 등록된 컨텐츠 리스트' <--(비교)--> '검색된 결과 리스트'
  /// NOTE : 아래 로직 사용안함. 다만 컨텐츠 개수가 늘어날 때 loop 돌리는게 부담이 될 수 있음
  /// 필요할 때 아래  로직을 사용
  /// 일단 주석 처리
  // Future<void> checkIsContentRegistered(
  //     {required ContentType contentType}) async {}
  //
  // TODO - 2023.05.24
  // 코드가 복잡한데 리팩토링이 필요함 (State 판별 로직)

  factory SearchedContent.fromMovieResponse(TmdbMovieDetailResponse response) {
    /// TMDB API에서 형식이 이상 firstAirDate 필드가 넘어옴
    /// 검증 로직이 필요
    String? verifyReleaseDate() {
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

    final obj = SearchedContent(
      contentId: response.id,
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.title,
      releaseDate: verifyReleaseDate(),
      state: BehaviorSubject<RegistrationStateOld>.seeded(
          RegistrationStateOld.isLoading),
    );

    if (ContentService.to.contentIdInfo!.movieContentIdList
        .contains(response.id)) {
      obj.state.add(RegistrationStateOld.registered);
    } else {
      obj.state.add(RegistrationStateOld.unRegistered);
    }

    return obj;
  }

  factory SearchedContent.fromTvResponse(TmdbTvDetailResponse response) {
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


    final obj = SearchedContent(
      contentId: response.id,
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.name,
      releaseDate: verifyReleaseDate(),
      state: BehaviorSubject<RegistrationStateOld>.seeded(
          RegistrationStateOld.isLoading),
    );

    if (ContentService.to.contentIdInfo!.tvContentIdList
        .contains(response.id)) {
      obj.state.add(RegistrationStateOld.registered);
    } else {
      obj.state.add(RegistrationStateOld.unRegistered);
    }

    return obj;
  }
}

// 등록 여부 필드 enum 값
enum RegistrationStateOld {
  isLoading,
  registered,
  unRegistered,
}
