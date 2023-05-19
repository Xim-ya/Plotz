import 'dart:io';

import 'package:soon_sak/utilities/index.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;

  final UserDataSource _dataSource;

  @override
  Future<Result<void>> addUserCurationInfo({
    required String qurationDocId,
    required String userId,
  }) async {
    try {
      final response = _dataSource.addUserQurationInfo(
        qurationDocId: qurationDocId,
        userId: userId,
      );
      return Result.success(response);
    } on Exception {
      return Result.failure(UserException.updateUserQurationInfoFailed());
    }
  }

  @override
  Future<Result<UserCurationSummary>> loadUserCurationSummary(
    String userId,
  ) async {
    try {
      final response = await _dataSource.loadUserCurationSummary(userId);
      return Result.success(UserCurationSummary.fromResponse(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<CurationContent>>> loadUserCurationContentList(
    String userId,
  ) async {
    try {
      final response = await _dataSource.loadUserCurationContentList(userId);
      return Result.success(
        response.map(CurationContent.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> addUserWatchHistory(
    WatchingHistoryRequest requestInfo,
  ) async {
    try {
      final response = await _dataSource.addUserWatchHistory(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<UserWatchHistoryItem>>> loadUserWatchHistory(
    String userId,
  ) async {
    try {
      final response = await _dataSource.loadUserWatchHistory(userId);
      response.removeWhere((e) => e == null);
      return Result.success(
        response.map((e) => UserWatchHistoryItem.fromResponse(e!)).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkDuplicateDisplayName(String inputName) async {
    try {
      final response = await _dataSource.checkDuplicateDisplayName(inputName);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUserProfile(UserProfileRequest requestInfo) async {
    try {
      final response = await _dataSource.updateUserProfile(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<String>> uploadUserProfileImgAndReturnUrl({
    required String userId,
    required File file,
  }) async {
    try {
      final response = await _dataSource.uploadUserProfileImgAndReturnUrl(
        userId: userId,
        file: file,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> withdrawUser(String userId) async {
    try {
      final response = await _dataSource.withdrawUser(userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
