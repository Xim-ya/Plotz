part of 'home_view_model.dart';


extension HomeViewModelPart on HomeViewModel  {

  // 홈 스크린 상단 노출 컨텐츠
  List<TopExposedContent>? get topExposedContentList => _topExposedContentList.value;

  //상단 노출 컨텐츠 데이터 로드 여부
  bool get isTopExposedContentListLoaded => _topExposedContentList.value != null;

  // 상단 노출 컨텐츠 > 헤더 영역 포스토 백그라운드 img url
  TopExposedContent get selectedTopExposedContent => _topExposedContentList.value![topExposedContentSliderIndex.value];

}




