part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 * 컨텐츠 상세 페이지 > 헤더 영역 컨트롤러 리소스
 * */

extension ContentDetailHeaderViewModel on ContentDetailViewModel {
  /* [Getters */

  /// 헤더 영역 이미지
  String? get headerBackdropImg =>
      passedArgument.posterImgUrl ??
      _contentDescriptionInfo?.posterImgUrl;


  /// 컨텐츠 설명 부분 (유튜브 컨텐츠 제목)
  /// 전달 받은 Argument가 있으면 argument 데이터를 사용
  String? get headerContentDesc => passedArgument.videoTitle.hasData
      ? passedArgument.videoTitle!
      : contentVideos?.singleTypeVideo.detailInfo?.videoTitle;

  // TODO: 블로그 포스팅용 예시 이후에 삭제 필요
  // RxString? get headerContentDesc => passedArgument.videoTitle.hasData
  //     ? passedArgument.videoTitle!.obs
  //     : contentVideos.value?.singleTypeVideo.detailInfo?.videoTitle.obs;

  // 컨텐츠 제목
  String? get headerTitle => passedArgument.title.hasData
      ? passedArgument.title!
      : _contentDescriptionInfo?.title;

  // 컨텐츠 TMDB 평점
  String? get rate => _contentDescriptionInfo?.rate.toStringAsFixed(2);

  // 컨텐츠 장르 리스트
  String? get genre => Formatter.formatGenreListToSingleStr(
      _contentDescriptionInfo?.genreList,);

  // 컨텐츠 개봉일
  String? get releaseDate => _contentDescriptionInfo?.releaseDate != null
      ? Formatter.dateToyyMMdd(_contentDescriptionInfo!.releaseDate!)
      : null;
}
