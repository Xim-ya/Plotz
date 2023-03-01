import 'package:soon_sak/data/api/version/response/version_response.dart';
import 'package:soon_sak/data/api/version/version_api.dart';
import 'package:soon_sak/data/dataSource/version/version_data_source.dart';
import 'package:soon_sak/data/mixin/fire_store_error_handler_mixin.dart';

class VersionDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements VersionDataSource {
  VersionDataSourceImpl(this._api);

  final VersionApi _api;

  @override
  Future<VersionResponse> loadVersionInfo(String platform) =>
      loadResponseOrThrow(() => _api.loadVersionInfo(platform));
}
