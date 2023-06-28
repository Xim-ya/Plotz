import 'dart:io';

import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/utilities/index.dart';

class UserRepositoryImpl implements UserRepository {
  UserRepositoryImpl({required UserDataSource dataSource})
      : _dataSource = dataSource;

  final UserDataSource _dataSource;

  @override
  Future<Result<void>> addUserCurationInfo({
    required String curationDocId,

  }) async {
    try {
      final response = _dataSource.addUserCurationInfo(
        curationDocId: curationDocId,

      );
      return Result.success(response);
    } on Exception {
      return Result.failure(UserException.updateUserQurationInfoFailed());
    }
  }

  @override
  Future<Result<UserCurationSummary>> loadUserCurationSummary() async {
    try {
      final response = await _dataSource.loadUserCurationSummary();
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
  Future<Result<bool>> checkIfUserHasPreferencesData( ) async {
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
