import 'package:soon_sak/data/dto/staticContent/response/content_key_response.dart';

class StaticContentKeys {
  final String bannerKey;
  final String topTenContentKey;
  final String categoryContent;

  StaticContentKeys({
    required this.bannerKey,
    required this.topTenContentKey,
    required this.categoryContent,
  });

  factory StaticContentKeys.fromResponse(ContentKeyResponse response) =>
      StaticContentKeys(
        bannerKey: response.bannerKey,
        topTenContentKey: response.topTenContentKey,
        categoryContent: response.categoryContent,
      );
}
