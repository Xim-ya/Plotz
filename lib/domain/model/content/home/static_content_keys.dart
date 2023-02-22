import 'package:soon_sak/utilities/index.dart';

class StaticContentKeys {
  final String bannerKey;
  final String topTenContentKey;
  final String categoryContentKey;

  StaticContentKeys({
    required this.bannerKey,
    required this.topTenContentKey,
    required this.categoryContentKey,
  });

  factory StaticContentKeys.fromResponse(ContentKeyResponse response) =>
      StaticContentKeys(
        bannerKey: response.bannerKey,
        topTenContentKey: response.topTenContentKey,
        categoryContentKey: response.categoryContent,
      );
}
