import 'package:soon_sak/data/dto/staticContent/response/top_ten_content_response.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.31
 *  컨텐츠 간략 정보를 담고 있는 데이터 모델
 *   [DTO]
 *   {
    "id": 113988,
    "posterImgUrl": "/f2PVrphK0u81ES256lw3oAZuF3x.jpg",
    "type": "tv"
    }
 * */

class ContentPosterShell {
  final String originId;
  final int contentId;
  final ContentType contentType;
  final String posterImgUrl;

  ContentPosterShell({
    required this.originId,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
  }); 

  factory ContentPosterShell.fromResponse(TopTenContentItemResponse response) =>
      ContentPosterShell(
        originId: response.id,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
      );

  // // Form Mock Json Data Response
  // factory ContentPosterShell.fromJson(Map<String, dynamic> json) {
  //   return ContentPosterShell(
  //     contentId:  SplittedIdAndType.fromOriginId(json['id']).id,
  //     posterImgUrl: json['posterImgUrl'],
  //     contentType: SplittedIdAndType.fromOriginId(json['id']).type,
  //     );
  // }
}
