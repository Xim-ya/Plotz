import 'package:soon_sak/data/api/version/response/version_response.dart';

abstract class VersionDataSource {
  Future<VersionResponse> loadVersionInfo(String platform);
}