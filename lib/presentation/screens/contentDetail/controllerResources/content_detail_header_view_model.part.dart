part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 * 컨텐츠 상세 페이지 > 헤더 영역 컨트롤러 리소스
 * */

extension ContentDetailHeaderViewModel on ContentDetailViewModel {
  /* [Getters */

  /// 컨텐츠 설명 부분 (유튜브 컨텐츠 제목)
  /// 전달 받은 Argument가 있으면 argument 데이터를 사용
  RxString? get headerContentDesc => passedArgument.description.hasData
      ? passedArgument.description!.obs
      : _contentDescriptionInfo.value?.overView.obs;

  // 컨텐츠 제목
  RxString? get headerTitle => passedArgument.title.hasData
      ? passedArgument.title!.obs
      : _contentDescriptionInfo.value?.title.obs;

  // 컨텐츠 TMDB 평점
  String? get rate => contentMainInfo?.rate.toString();

  // 컨텐츠 장르 리스트
  String? get genre =>
      Formatter.formatGenreListToSingleStr(contentMainInfo?.genreList);

  // 컨텐츠 개봉일
  String? get releaseDate => _contentDescriptionInfo.value?.releaseDate != null
      ? Formatter.dateToyyMMdd(contentMainInfo!.releaseDate)
      : null;

}
