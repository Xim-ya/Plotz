import 'package:soon_sak/data/index.dart';

class VersionInfo {
  final String versionCode;
  final String systemAvailable;

  VersionInfo({
    required this.versionCode,
    required this.systemAvailable,
  });

  factory VersionInfo.fromResponse(VersionResponse response) => VersionInfo(
        versionCode: response.versionCode,
        systemAvailable: response.systemAvailable,
      );
}
