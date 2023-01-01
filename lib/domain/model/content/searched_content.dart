import 'package:uppercut_fantube/utilities/extensions/determine_content_type.dart';
import 'package:uppercut_fantube/utilities/index.dart';

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
  final Rx<ContentRegisteredValue> isRegisteredContent;
  late String? youtubeVideoId;

  SearchedContent({
    required this.contentId,
    required this.posterImgUrl,
    required this.title,
    required this.releaseDate,
    required this.isRegisteredContent,
    this.youtubeVideoId,
  });

  /// 등록된 컨텐츠인지 판별하는 메소드.
  /// 서버에 저장된 '등록된 모든 컨텐츠' 데이터를 기반으로 등록여부를 확인함.
  /// '서버에 등록된 컨텐츠 리스트' <--(비교)--> '검색된 결과 리스트'
  Future<void> checkIsContentRegistered(
      {required ContentType contentType}) async {
    // 1. 등록된 전체 컨텐츠 리스트 데이터가 호출되어 있지 않다면. 리스트 호출
    if (contentType.isTv &&
        ContentService.to.totalListOfRegisteredTvContent.value == null) {
      await ContentService.to.fetchAllOfRegisteredTvContent();
    } else if (contentType.isMovie &&
        ContentService.to.totalListOfRegisteredMovieContent.value == null) {
      await ContentService.to.fetchAllOfRegisteredMovieContent();
    }

    // 2. 등록된 전체 컨텐츠의 [contentId] 값으로 검색된 결과 리스트의 등록 여부를 확인
    for (var element
        in ContentService.to.returnTotalListBaseOnType(type: contentType)!) {
      if (element.contentId == contentId) {
        isRegisteredContent.value = ContentRegisteredValue.registered;
        // TODO 필요 없으면 삭제
        // youtubeVideoId = element.videoId;
        break;
      } else {
        isRegisteredContent.value = ContentRegisteredValue.unRegistered;
      }
    }
  }

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

    return SearchedContent(
      contentId: response.id,
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.title,
      releaseDate: verifyReleaseDate(),
      isRegisteredContent: ContentRegisteredValue.isLoading.obs,
    );
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

    return SearchedContent(
      contentId: response.id,
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.name,
      releaseDate: verifyReleaseDate(),
      isRegisteredContent: ContentRegisteredValue.isLoading.obs,
    );
  }
}

// 등록 여부 필드 enum 값
enum ContentRegisteredValue {
  isLoading,
  registered,
  unRegistered,
}
