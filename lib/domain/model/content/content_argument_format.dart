import 'package:uppercut_fantube/utilities/index.dart';

/// 컨텐츠 리스트 섹션에서 [컨텐츠 상세페이지]로 이동할 때 argument로 넘겨주는 데이터 모델
/// [TopExposedContentList]의 경우 [title] [description] [thumbnailUrl] 필드를 넘겨줄 수 있지만
/// 다른 컨텐츠 리스트 섹션에서는 해당 값이 존재하지 않기 때문에 해당 필드는 nullable 처리를 함.
class ContentArgumentFormat {
  final String originId;
  final int contentId;
  final ContentType contentType;
  final String? videoId;
  final String? title;
  final String? videoTitle;
  final String? thumbnailUrl;
  final String? posterImgUrl;
  final String? backdropImgUrl;

  ContentArgumentFormat({
    required this.originId,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
     this.videoId,
    this.title,
    this.videoTitle,
    this.backdropImgUrl,
    this.thumbnailUrl,
  });
}
