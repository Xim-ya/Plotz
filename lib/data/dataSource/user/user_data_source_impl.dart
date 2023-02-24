import 'package:soon_sak/utilities/index.dart';

class UserDataSourceImpl
    with FireStoreErrorHandlerMixin, FirebaseIsolateHelper
    implements UserDataSource {
  UserDataSourceImpl(this._api);

  final UserApi _api;

  @override
  Future<void> addUserQurationInfo(
          {required String qurationDocId, required String userId}) =>
      loadResponseOrThrow(
        () => _api.addUserCurationInfo(
          qurationDocId: qurationDocId,
          userId: userId,
        ),
      );

  @override
  Future<UserCurationSummaryResponse> loadUserCurationSummary(String userId) =>
      loadResponseOrThrow(() => _api.loadUserCurationSummary(userId));

  @override
  Future<List<CurationContentResponse>> loadUserCurationContentList(
      String userId) async {
    return loadResponseOrThrow(() => _api.loadUserCurationContentList(userId));
  }

  @override
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo) {
    return loadResponseOrThrow(
      () => _api.addUserWatchHistory(requestInfo),
    );
  }

  @override
  Future<List<UserWatchHistoryItemResponse>> loadUserWatchHistory(
          String userId) =>
      loadWithFirebaseIsolate(
        () => loadResponseOrThrow(
          () => _api.loadUserWatchHistory(userId),
        ),
      );
}
