import 'package:uppercut_fantube/domain/model/content/explore_content_id_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2023.01.14
 *  탐색 스크린에서 사용되는 데이터 모델.
 * */

class ExploreContent {
  final ExploreContentIdInfo idInfo; // contentId, videoId
  late final Rxn<ExploreContentYoutubeInfo> youtubeInfo = Rxn(); // 컨텐츠 유튜브 정보
  late final Rxn<ExploreContentDetailInfo> detailInfo =
      Rxn(); // 컨텐츠 상세 정보 (TMDB)
  final RxBool isUpdated = false.obs; // 유튜브 정보, 상세 정보 업데이트 여부

  ExploreContent({required this.idInfo});

  /* Intents */

  // 유튜브 정보 업데이트
  Future<void> updateYoutubeChannelInfo( ) async {
    final channelRes = await YoutubeMetaData.yt.channels.getByVideo(idInfo.videoId);
    final videoRes = await YoutubeMetaData.yt.videos.get(idInfo.videoId);
    youtubeInfo.value = ExploreContentYoutubeInfo.fromResponse(
        channelRes: channelRes, videoRes: videoRes);
  }

  // 컨텐츠 상세 정보 업데이트 (TMDMB)
  Future<void> updateContentDetailInfo( ) async {
    final ExploreContentDetailInfo responseResult;

    if (idInfo.contentType == ContentType.movie) {
      final response =
          await TmdbDataSource.to.loadTmdbMovieDetailResponse(idInfo.contentId);
      responseResult = ExploreContentDetailInfo.fromMovieResponse(response);
    } else {
      final response =
          await TmdbDataSource.to.loadTmdbTvDetailResponse(idInfo.contentId);
      responseResult = ExploreContentDetailInfo.fromTvResponse(response);
    }

    detailInfo.value = responseResult;
  }

  factory ExploreContent.fromIdInfoResponse(ExploreContentIdInfo response) {
    return ExploreContent(idInfo: response);
  }
}

class ExploreContentYoutubeInfo {
  final String videoTitle; // 유튜브 비디오 제목
  final String channelImgUrl; // 유튜브 채널 이미지
  final String channelName; // 유튜브 채널 이름
  final int? subscribers;

  ExploreContentYoutubeInfo(
      {required this.videoTitle,
      required this.channelImgUrl,
      required this.channelName,
      required this.subscribers}); // 구독자 수

  factory ExploreContentYoutubeInfo.fromResponse(
      {required Channel channelRes, required Video videoRes}) {
    return ExploreContentYoutubeInfo(
      videoTitle: videoRes.title,
      channelImgUrl: channelRes.logoUrl,
      channelName: channelRes.title,
      subscribers: channelRes.subscribersCount,
    );
  }
}

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
      TmdbMovieDetailResponse response) {
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
        releaseDate: verifiedReleaseDate());
  }

  // 드라마
  factory ExploreContentDetailInfo.fromTvResponse(
      TmdbTvDetailResponse response) {
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
        releaseDate: verifyReleaseDate());
  }
}
