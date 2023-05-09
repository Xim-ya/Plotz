part of 'home_view_model.dart';

/** Created By Ximya - 2023.03.20
 *  홈 스크린에 사용되는 핵심 ViewModel Resources
 * */

extension HomeViewModelPart on HomeViewModel {
  // 배터 컨텐츠 리스트
  List<BannerItem>? get bannerContentList => _bannerContents.value?.contentList;

  // 상단 노출 컨텐츠 데이터 로드 여부
  bool get isBannerContentsLoaded => _bannerContents.value.hasData;

  // 선택된 배너 컨텐츠 포스터 이미지
  String? get selectedBannerContentBackdropImgUrl => _bannerContents
      .value?.contentList[bannerContentsSliderIndex.value].backdropImgUrl;

  // 선택된 배너 콘텐츠
  BannerItem? get selectedBannerContent =>
      _bannerContents.value?.contentList[bannerContentsSliderIndex.value];

  // Top10 컨텐츠 로드 여부
  bool get isTopTenContentsLoaded => _topTenContents.value.hasData;

  // Top10 컨텐츠
  TopTenContentsModel? get topTenContents => _topTenContents.value;

  // 상단 노출 카테고리, index를 기준으론 필요 카테고리를 반환
  TopPositionedCategory selectedTopPositionedCategory(int index) => topPositionedCategory.value![index];

  // 상단 노출 카테고리 콜렉션 로드 여부
  bool get isTopPositionedCollectionLoaded => topPositionedCategory.value.hasData;


}
