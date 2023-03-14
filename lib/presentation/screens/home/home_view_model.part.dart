part of 'home_view_model.dart';

extension HomeViewModelPart on HomeViewModel {
  // 홈 스크린 상단 노출 컨텐츠
  List<BannerItem>? get bannerContentList =>
      _bannerContent.value?.contentList;

  //상단 노출 컨텐츠 데이터 로드 여부
  bool get isBannerContentsLoaded {
    return _bannerContent.value.hasData;
  }

  // 선택된 배너 컨텐츠
  BannerItem? get selectedTopExposedContent =>
      _bannerContent.value?.contentList[topExposedContentSliderIndex.value];


  // Top10 컨텐츠 로드 여부
  bool get isTopTenContentsLoaded {
    return _topTenContents.value.hasData;
  }

  // Top10 컨텐츠
  TopTenContentsModel? get topTenContents => _topTenContents.value;


  // 카테고리 컨텐츠 collection
  List<CategoryContentSection>? get categoryContentCollection => loadPagedCategoryCollectionUseCase.categoryContentCollection.value;
  // CategoryContentCollection? get categoryContentCollection => _categoryContentCollection.value;
}
