import 'package:soon_sak/utilities/index.dart';


/// 컨텐츠 리스트 섹션에서 [컨텐츠 상세페이지]로 이동할 때 argument로 넘겨주는 데이터 모델
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
  final String? channelName;
  final String? channelLogoImgUrl;
  final int? subscribersCount;

  ContentArgumentFormat({
    required this.originId,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
    this.channelName,
    this.channelLogoImgUrl,
    this.subscribersCount,
    this.videoId,
    this.title,
    this.videoTitle,
    this.backdropImgUrl,
    this.thumbnailUrl,
  });
}
