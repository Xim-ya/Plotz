import 'dart:io';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;

  final UserDataSource _dataSource;

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
  Future<Result<List<UserWatchHistoryItem>>> loadUserWatchHistory() async {
    try {
      final response = await _dataSource.loadUserWatchHistory();
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
    required File file,
  }) async {
    try {
      final response = await _dataSource.uploadUserProfileImgAndReturnUrl(
        file: file,
      );
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> withdrawUser() async {
    try {
      final response = await _dataSource.withdrawUser();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUserPreferences(
      UserOnboardingPreferredRequest req) async {
    try {
      final response = await _dataSource.updateUserPreferences(req);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<bool> isOnboardingProgressDone() {
    try {
      final response = _dataSource.isOnboardingProgressDone();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<void> saveUserLocalData(String userId) {
    try {
      final response = _dataSource.saveUserLocalData(userId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<UserBox?> getUserLocalData() {
    try {
      final response = _dataSource.getUserLocalData();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkIfUserHasPreferencesData() async {
    try {
      final response = await _dataSource.checkIfUserHasPreferencesData();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<void> changeUserOnboardingState() {
    try {
      final response = _dataSource.changeUserOnboardingState();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Result<void> clearUserLocalData() {
    try {
      final response = _dataSource.clearUserLocalData();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUserChannelPreference(String channelId) async {
    try {
      final response = await _dataSource.updateUserChannelPreference(channelId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateUserGenrePreference(
      List<PreferredRequestContent> genres) async {
    try {
      final response = await _dataSource.updateUserGenrePreference(genres);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
