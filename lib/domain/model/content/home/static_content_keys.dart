import 'package:uppercut_fantube/data/dto/staticContent/response/content_key_response.dart';

class StaticContentKeys {
  final String bannerKey;
  final String topTenContentKey;

  StaticContentKeys({required this.bannerKey, required this.topTenContentKey});

  factory StaticContentKeys.fromResponse(ContentKeyResponse response) =>
      StaticContentKeys(
        bannerKey: response.bannerKey,
        topTenContentKey: response.topTenContentKey,
      );
}
