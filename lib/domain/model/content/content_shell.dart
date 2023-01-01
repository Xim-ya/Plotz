import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.12.31
 *  컨텐츠 간략 정보를 담고 있는 데이터 모델
 *   [DTO]
 *   {
    "id": 113988,
    "posterImgUrl": "/f2PVrphK0u81ES256lw3oAZuF3x.jpg",
    "type": "tv"
    }
 * */

class ContentShell {
  final int contentId;
  final String posterImgUrl;
  final ContentType contentType;

  ContentShell(
      {required this.contentId,
      required this.posterImgUrl,
      required this.contentType});

  factory ContentShell.fromJson(Map<String, dynamic> json) {
    return ContentShell(
      contentId: json['id'],
      posterImgUrl: json['posterImgUrl'],
      contentType: ContentType.fromString(json['type']),
    );
  }
}
