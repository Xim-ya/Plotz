import 'package:soon_sak/utilities/index.dart';

abstract class VersionRepository {
  Future<Result<VersionInfo>> loadVersionInfo(String platform);
}
