import 'package:soon_sak/utilities/index.dart';

extension DeterminContentType on ContentType {
  bool get isMovie {
    return this == ContentType.movie ? true : false;
  }

  bool get isTv {
    return this == ContentType.tv ? true : false;
  }
}
