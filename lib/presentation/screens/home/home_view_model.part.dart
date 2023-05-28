part of 'home_view_model.dart';

/** Created By Ximya - 2023.03.20
 *  홈 스크린에 사용되는 핵심 ViewModel Resources
 * */

extension HomeViewModelPart on HomeViewModel {
  // 배터 컨텐츠 리스트
  List<BannerItem>? get bannerContentList => bannerContents?.contentList;

  // 상단 노출 컨텐츠 데이터 로드 여부
  bool get isBannerContentsLoaded => bannerContents.hasData;

  // 선택된 배너 콘텐츠
  BannerItem? get selectedBannerContent =>
      bannerContents?.contentList[bannerContentsSliderIndex];

  // Top10 컨텐츠 로드 여부
  bool get isTopTenContentsLoaded => topTenContents.hasData;

  // Top10 컨텐츠
  TopTenContentsModel? get topTenContents => topTenContents;

  // 상단 노출 카테고리, index를 기준으론 필요 카테고리를 반환
  TopPositionedCategory selectedTopPositionedCategory(int index) =>
      topPositionedCategory![index];

  // 상단 노출 카테고리 콜렉션 로드 여부
  bool get isTopPositionedCollectionLoaded =>
      topPositionedCategory.hasData;

  // 채널 리스트 개수
  int get countOfChannelList => channelList?.length ?? 5;

  // 채널 데이터 로드 여부
  bool get isChannelListLoaded => channelList.hasData;

  // 채널리스트 요소 (인덱스 기준)
  ChannelModel channelItem(int index) => channelList![index];

}
