part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 * 컨텐츠 상세 페이지 > 헤더 영역 컨트롤러 리소스
 * */

extension ContentDetailHeaderViewModel on ContentDetailViewModel {
  /* [Getters */

  /// 헤더 영역 이미지
  String? get headerBackdropImg {
    if (videoInfo == null) return null;

    if (videoInfo!.videoFormat == ContentVideoFormat.multipleMovie ||
        videoInfo!.videoFormat == ContentVideoFormat.multipleTv) {
      return videoInfo!.videos[selectedEpisode - 1].posterImageUrl;
    } else {
      return _contentDescriptionInfo?.posterImgUrl;
    }
  }

  String get contentTypeToString => _passedArgument.contentType.asText;

  /// 컨텐츠 설명 부분 (유튜브 컨텐츠 제목)
  /// 전달 받은 Argument가 있으면 argument 데이터를 사용
  String? get contentVideoTitle {

    if (videoInfo == null) return null;

    if (videoInfo!.videoFormat == ContentVideoFormat.multipleMovie ||
        videoInfo!.videoFormat == ContentVideoFormat.multipleTv) {
      return videoInfo!
          .videos[selectedEpisode - 1].youtubeInfo.valueOrNull?.videoTitle;
    } else {
      return passedArgument.videoTitle.hasData
          ? passedArgument.videoTitle!
          : videoInfo?.videos[0].youtubeInfo.valueOrNull?.videoTitle;
    }
  }



  // 컨텐츠 제목
  String? get headerTitle => passedArgument.title.hasData
      ? passedArgument.title!
      : _contentDescriptionInfo?.title;

  // 컨텐츠 TMDB 평점
  double? get rate => _contentDescriptionInfo.hasData
      ? _contentDescriptionInfo!.rate / 2
      : null;

  // 컨텐츠 장르 리스트
  String? get genre => Formatter.splitGenresByDots(
        _contentDescriptionInfo?.genreList,
      );


  // 개봉년도 && 방영년도
  String? get releaseYear => _contentDescriptionInfo?.releaseDate != null
      ? Formatter.dateToYear(_contentDescriptionInfo!.releaseDate!)
      : null;
}
