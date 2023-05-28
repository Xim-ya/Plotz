part of '../content_detail_view_model.dart';

/** Created By Ximya - 2023.1.1
 *  컨텐츠 비디오 섹션 뷰
 *  [ContentVideoFormat]에 따라 리소스를 다르게 분리함.
 * */

extension ContentDetailVideoViewModel on ContentDetailViewModel {
  // 컨텐츠 비디오 포맷
  ContentVideoFormat? get contentVideoFormat =>
      contentVideos?.contentVideoFormat;

  /// 비디오 컨텐츠 로드 여부
  /// 컨텐츠 타입 & 비디오 타입 조건별로 반환하는 값이 다름.
  bool get isVideoContentLoaded {
    if (contentType.isMovie) {
      return contentVideos?.isDetailInfoLoaded ?? false;
    } else {
      if (contentVideos?.contentVideoFormat ==
          ContentVideoFormat.multipleTv) {
        return contentVideos?.isSeasonInfoLoaded ?? false;
      } else {
        return contentVideos?.isDetailInfoLoaded ?? false;
      }
    }
  }

  /* [ContentVideoFormat] - single 타입 리소스 (movie, tv)*/
  // 유튜브 영상 썸네일 이미지
  String? get singleVideoThumbnailUrl =>
      contentVideos?.singleTypeVideo.detailInfo?.videoThumbnailUrl;

  String? get singleVideoId =>
      passedArgument.videoId ?? contentVideos?.singleTypeVideo.videoId;

  // 유튜브 컨텐츠 조회수
  String? get singleVideoViewCount => Formatter.formatNumberWithUnit(
        contentVideos?.singleTypeVideo.detailInfo?.viewCount,
        isViewCount: true,
      );

  // 유튜브 컨텐츠 좋아요 수
  String? get singleLikesCount => Formatter.formatNumberWithUnit(
      contentVideos?.singleTypeVideo.detailInfo?.likeCount,);

  // 유튜브 컨텐츠 업로드 일자
  String? get singleUploadDate => Formatter.getDateDifferenceFromNow(
      contentVideos?.singleTypeVideo.detailInfo?.uploadDate,);

  /* [ContentVideoFormat] - multiple 타입 리소스  */

  // 멀티 비디오 객체
  List<ContentVideoItem>? get multipleVideoInfo =>
      contentVideos?.multipleTypeVideos;
}
