import 'package:single_import_generator/single_import_generator.dart';
import 'package:soon_sak/utilities/index.dart';
import 'package:soon_sak/utilities/extensions/determine_content_type.dart';

/** Created By ximya - 2022.12.17
 *  컨텐츠 타입 - '영화' '드라마'
 * */

@SingleImport()
enum ContentType {
  tv('드라마'),
  movie('영화');

  const ContentType(this.name);

  final String name;

  factory ContentType.fromString(String originStr) {
    switch (originStr) {
      case 'tv':
        return ContentType.tv;
      case 't':
        return ContentType.tv;
      case 'movie':
        return ContentType.movie;
      case 'm':
        return ContentType.movie;
      default:
        throw Exception('enum not found');
    }
  }

  String get getTypeCharacter {
    if (isTv) {
      return 't';
    } else {
      return 'm';
    }
  }

  String get asText {
    return isTv ? '드라마' : '영화';
  }
}
