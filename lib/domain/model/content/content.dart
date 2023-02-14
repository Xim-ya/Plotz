import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.01
 *  가장 기본의 컨텐츠 데이터 모델
 *  General한 쓰임새를 가지고 있음
 *  contentId & contentType 필드값만 필수적으로 받음 (최소 단위)
 *  TODO: 기존에 사용하고 있는 컨텐츠 모델들이 많은데 해당 모델로 통합할 예정
 * */

class Content {
  late final int id;
  late String? videoId;
  late ContentType? type;
  late ContentDetail? detail;
  late YoutubeVideo? youtubeVideo;

  Content(
      {required this.id,
      this.videoId,
      this.type,
      this.detail,
      this.youtubeVideo});
}

class YoutubeVideo {
  late String? title; // 유튜브 영상 제목
  late String? channelName; // 채널 이름
  late String? channelImg; // 채널 이미지
  late int? subscriberCount; // 구독자 수

  YoutubeVideo(
      {this.title,
      this.channelName,
      this.channelImg,
      this.subscriberCount}); // 채널 이미지

}

class ContentDetail {
  final String? title; // 컨텐츠 제목
  final double? rate; // 평점
  final String? posterImgUrl; // 포스터 이미지 url
  final String? backDropImgUrl; // 컨텐츠 배경 이미지 url
  final List<String>? genreList; // 장르 타입 리스트
  final String? releaseDate; // 컨텐츠 출시일
  final String? overView; // 컨텐츠 설명
  final ContentSeasonType? contentEpicType; // 시리즈물 or 단일 컨텐츠
  final String? airStatus; // 컨텐츠 방영 상태
  late List<SeasonInfo>? seasonInfoList; // 시즌 정보 리스트

  ContentDetail({
    this.posterImgUrl,
    this.title,
    this.rate,
    this.genreList,
    this.releaseDate,
    this.overView,
    this.backDropImgUrl,
    this.contentEpicType,
    this.airStatus,
    this.seasonInfoList,
  });

  // ContentType == movie인 response
  factory ContentDetail.fromMovieDetailResponse(
      TmdbMovieDetailResponse response) {
    List<String> formattedGenre = [];

    if (response.genres.hasData) {
      for (var ele in response.genres!) {
        // "Action & Adventure" 장르 데이터가 이런 형태도 넘어온다면 Split 함.
        if (ele.name.contains('&')) {
          final List<String> splitGenre = ele.name.split('&');
          formattedGenre.addAll(splitGenre);
        } else {
          formattedGenre.add(ele.name);
        }
      }
    }

    return ContentDetail(
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.title,
      rate: response.vote_average,
      genreList: formattedGenre,
      releaseDate: response.release_date,
      overView: response.overview,
      backDropImgUrl: response.backdrop_path,
    );
  }

  // ContentType == tv인 response
  factory ContentDetail.fromTvDetailResponse(TmdbTvDetailResponse response) {
    List<String> formattedGenre = [];

    if (response.genres.hasData) {
      for (var ele in response.genres!) {
        // "Action & Adventure" 장르 데이터가 이런 형태도 넘어온다면 Split 함.
        if (ele.name.contains('&')) {
          final List<String> splitGenre = ele.name.split('&');
          formattedGenre.addAll(splitGenre);
        } else {
          formattedGenre.add(ele.name);
        }
      }
    }

    return ContentDetail(
      posterImgUrl: response.poster_path ?? response.backdrop_path,
      title: response.name,
      rate: response.vote_average,
      genreList: formattedGenre,
      releaseDate: response.first_air_date,
      contentEpicType:
          ContentSeasonType.fromSeasonCount(response.number_of_seasons),
      overView: response.overview,
      airStatus: _translateTvContentStatus(response.status!),
      backDropImgUrl: response.backdrop_path,
      seasonInfoList:
          response.seasons?.map((e) => SeasonInfo.fromResponse(e)).toList(),
    );
  }
}

String _translateTvContentStatus(String status) {
  switch (status) {
    case 'Canceled':
      return '방영 취소';
    case 'Ended':
      return '방영 종료';
    case 'In Production':
      return '제작 중';
    case 'Pilot':
      return '파일럿';
    case 'Returning Series':
      return '다음 시즌 방영 예정';
    default:
      return '정보 없음';
  }
}
