import 'package:soon_sak/data/index.dart';


class StaticContentKeys {
  final String bannerKey;
  final String topTenContentKey;
  final String categoryContentKey1;
  final String categoryContentKey2;
  final String topPositionedCollectionKey;

  StaticContentKeys({
    required this.bannerKey,
    required this.topTenContentKey,
    required this.categoryContentKey1,
    required this.categoryContentKey2,
    required this.topPositionedCollectionKey,
  });

  factory StaticContentKeys.fromResponse(ContentKeyResponse response) =>
      StaticContentKeys(
        bannerKey: response.bannerKey,
        topTenContentKey: response.topTenContentKey,
        categoryContentKey1: response.categoryContent1,
        categoryContentKey2: response.categoryContent2,
        topPositionedCollectionKey: response.topPositionedCollectionKey,
      );
}
