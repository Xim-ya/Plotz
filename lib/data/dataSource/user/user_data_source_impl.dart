import 'package:soon_sak/data/api/user/user_api.dart';
import 'package:soon_sak/data/dataSource/user/user_data_source.dart';
import 'package:soon_sak/utilities/index.dart';

class UserDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements UserDataSource {
  UserDataSourceImpl(this._api);

  final UserApi _api;

  @override
  Future<void> addUserQurationInfo(
          {required String qurationDocId, required String userId}) =>
      loadResponseOrThrow(
        () => _api.addUserQurationInfo(
            qurationDocId: qurationDocId, userId: userId),
      );
}
