import 'package:soon_sak/utilities/index.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl(this._dataSource);

  final UserDataSource _dataSource;

  @override
  Future<Result<void>> addUserQurationInfo(
      {required String qurationDocId, required String userId}) async {
    try {
      final response = _dataSource.addUserQurationInfo(
          qurationDocId: qurationDocId, userId: userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(UserException.updateUserQurationInfoFailed());
    }
  }

  @override
  Future<Result<UserCurationSummary>> loadUserCurationSummary(
      String userId) async {
    try {
      final response = await _dataSource.loadUserCurationSummary(userId);
      return Result.success(UserCurationSummary.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<CurationContent>>> loadUserCurationContentList(
      String userId) async {
    try {
      final response = await _dataSource.loadUserCurationContentList(userId);
      return Result.success(
          response.map(CurationContent.fromResponse).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> addUserWatchHistory(
      WatchingHistoryRequest requestInfo) async {
    try {
      final response = await _dataSource.addUserWatchHistory(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<UserWatchHistoryItem>>> loadUserWatchHistory(
      String userId) async {
    try {
      final response = await _dataSource.loadUserWatchHistory(userId);
      return Result.success(
        response.map(UserWatchHistoryItem.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
