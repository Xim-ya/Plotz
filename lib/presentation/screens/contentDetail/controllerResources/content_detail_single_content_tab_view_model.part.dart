part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 *  컨텐츠 탭뷰에 사용되는 컨트롤러 리소스
 * */

extension ContentDetailSingleContentTabViewModel on ContentDetailViewModel {
  // 컨텐츠 에피소드 리스트
  List<ContentEpisodeInfoItem>? get contentEpisodeList =>
      _contentEpisodeList;

  /// 유튜브 컨텐츠 썸네일 이미지
  /// 이전 화면에서 전달받은 컨텐츠 썸네일 값이 있다면 해당 데이터 사용. 아니라면 networking한 데이터 사용.
  String? get youtubeImgThumbnailUrl => passedArgument.thumbnailUrl.hasData
      ? passedArgument.thumbnailUrl!
      : _youtubeVideoContentInfo?.videoThumbnailUrl;

  // 유튜브 컨텐츠 조회수
  String? get viewCount => Formatter.formatNumberWithUnit(
        oldContentVideos?.mainViewCount,
        isViewCount: true,
      );

  // 컨텐츠 설명
  String? get contentOverView => _contentDescriptionInfo?.overView;

  // 시즌 에피소드 섹션 포스터 이미지 넓이
  double get seasonEpisodeImgWidth => (SizeConfig.to.screenWidth - 32) * 0.397;

}
