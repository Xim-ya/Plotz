part of '../content_detail_view_model.dart';


/** Created By Ximya - 2022.12.17
 * 컨텐츠 정보 관련 컨트롤러 리소스
 * [대부분 TMDB API]와 관련 있음
 * */

extension ContentInfoViewModelPart on ContentDetailViewModel {

  // 컨텐츠 데이터
  ContentDescriptionInfo? get contentDescriptionInfo => _contentDescriptionInfo.value;

  // 컨텐츠 데이터 로드 여부
  bool get isContentInfoLoaded => _contentDescriptionInfo.value != null;

}