import 'package:soon_sak/domain/index.dart';

extension DeterminContentType on MediaType {
  bool get isMovie {
    return this == MediaType.movie ? true : false;
  }

  bool get isTv {
    return this == MediaType.tv ? true : false;
  }
}
