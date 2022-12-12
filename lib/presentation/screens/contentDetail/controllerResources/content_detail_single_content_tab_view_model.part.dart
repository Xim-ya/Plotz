part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 *  [ContentSeasonType] 이 [single] 일 때
 *  컨텐츠 탭에 보여지는 컨트롤러 리소스
 * */

extension ContentDetailSingleContentTabViewModel on ContentDetailViewModel {
   // 컨텐츠 에피소드 리스트
  List<ContentEpisodeInfoItem>? get contentEpisodeList => _contentEpisodeList.value;



  /// 유튜브 컨텐츠 썸네일 이미지
  /// 이전 화면에서 전달받은 컨텐츠 썸네일 값이 있다면 해당 데이터 사용. 아니라면 networking한 데이터 사용.
  RxString? get youtubeImgThumbnailUrl => passedArgument.thumbnailUrl.hasData
      ? passedArgument.thumbnailUrl!.obs
      : _youtubeVideoContentInfo.value?.videoThumbnailUrl.obs;

  // 유튜브 컨텐츠 좋아요 수
  String? get likesCount =>
      Formatter.formatViewAndLikeCount(youtubeVideoContentInfo?.likeCount);

  // 유튜브 컨텐츠 조회수
  String? get viewCount => Formatter.formatViewAndLikeCount(
        youtubeVideoContentInfo?.viewCount,
        isViewCount: true,
      );

  // 유튜브 컨텐츠 업로드 일자
  String? get youtubeUploadDate => Formatter.getDateDifferenceFromNow(youtubeVideoContentInfo?.uploadDate);

  // 컨텐츠 설명
  String? get contentOverView => _contentDescriptionInfo.value?.overView;
}
