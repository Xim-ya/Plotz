part of 'home_view_model.dart';


extension HomeViewModelPart on HomeViewModel  {

  // 홈 스크린 상단 노출 컨텐츠
  List<BannerContent>? get topExposedContentList => _topExposedContentList.value;

  //상단 노출 컨텐츠 데이터 로드 여부
  bool get isTopExposedContentListLoaded => _topExposedContentList.value != null;

  // 선택된 배너 컨텐츠
  BannerContent get selectedTopExposedContent => _topExposedContentList.value![topExposedContentSliderIndex.value];

}




