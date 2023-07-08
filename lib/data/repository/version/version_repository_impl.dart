import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class VersionRepositoryImpl extends VersionRepository {
  VersionRepositoryImpl(this._dataSource);

  final VersionDataSource _dataSource;

  @override
  Future<Result<VersionInfo>> loadVersionInfo(String platform) async {
    try {
      final response = await _dataSource.loadVersionInfo(platform);
      return Result.success(VersionInfo.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
