import 'package:soon_sak/utilities/index.dart';

/** Created BY Ximya - 2023.01.14
 *  컨텐츠의 originId를 특정 포맷으로 Split하고
 *  Split한 데이터를 매핑하는 모델
 *  ex)
 *  originId = 'm-1245'
 *  [SplittedIdAndType] id = 1245 / type = ContentType.movie
 * */

class SplittedIdAndType {
  final int id;
  final ContentType type;

  SplittedIdAndType({required this.id, required this.type});

  factory SplittedIdAndType.fromOriginId(String originId) {
    final List<String> splittedOrigin = originId.split('-');
    return SplittedIdAndType(
        id: int.parse(splittedOrigin[1]),
        type: ContentType.fromString(splittedOrigin[0]));
  }
}
