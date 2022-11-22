import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.11.22
 *  [ContentDetailScreen] > 컨텐츠 탭에서 사용되는 데이터 모델
 *  좋아요 수 / 조회수 / 컨텐츠 등록일 데이터를 매핑
 * */

class YoutubeVideoContentInfo {
  final int? likeCount; // 좋아요 수
  final int viewCount; // 조회수
  final String? uploadDate; // 컨텐츠 등록일

  YoutubeVideoContentInfo(
      {required this.likeCount,
      required this.viewCount,
      required this.uploadDate});

  factory YoutubeVideoContentInfo.fromResponse(Video response) {
    return YoutubeVideoContentInfo(
        likeCount: response.engagement.likeCount,
        viewCount: response.engagement.viewCount,
        uploadDate: response.uploadDateRaw);
  }
}
