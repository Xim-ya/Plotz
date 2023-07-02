import 'dart:io';
import 'package:soon_sak/data/api/user/request/preferred_content_request.dart';
import 'package:soon_sak/data/api/user/request/user_onboarding_preferred_request.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';
import 'package:soon_sak/data/local/dao/user/user_dao.dart';
import 'package:soon_sak/utilities/index.dart';

class UserDataSourceImpl
    with FireStoreErrorHandlerMixin
    implements UserDataSource {
  UserDataSourceImpl({required UserApi api, required UserDao local})
      : _api = api,
        _local = local;

  final UserApi _api;
  final UserDao _local;

  @override
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo) {
    return loadResponseOrThrow(
      () => _api.addUserWatchHistory(requestInfo),
    );
  }

  @override
  Future<List<UserWatchHistoryItemResponse?>> loadUserWatchHistory() =>
      loadResponseOrThrow(
        () => _api.loadUserWatchHistory(_local.value!.userId),
      );

  @override
  Future<bool> checkDuplicateDisplayName(String inputName) =>
      loadResponseOrThrow(() => _api.checkDuplicateDisplayName(inputName));

  // 프로필 정보 업데이트
  @override
  Future<void> updateUserProfile(UserProfileRequest requestInfo) async {
    return loadResponseOrThrow(() => _api.updateUserProfile(requestInfo));
  }

  @override
  Future<String> uploadUserProfileImgAndReturnUrl({required File file}) {
    return loadResponseOrThrow(
      () => _api.uploadUserProfileImgAndReturnUrl(
          userId: _local.value!.userId, file: file),
    );
  }

  @override
  Future<void> withdrawUser() async =>
      loadResponseOrThrow(() => _api.withdrawUser(_local.value!.userId));

  @override
  bool isOnboardingProgressDone() {
    final result = _local.value?.isOnboardingProgressDone ?? false;
    return result;
  }

  @override
  Future<void> updateUserPreferences(UserOnboardingPreferredRequest req) {
    return loadResponseOrThrow(
        () => _api.updateUserPreferences(req, _local.userId!));
  }

  @override
  void saveUserLocalData(String userId) {
    _local.updateUserId(userId);
  }

  @override
  UserBox? getUserLocalData() => _local.value;

  @override
  Future<bool> checkIfUserHasPreferencesData() async {
    final result = _api.checkIfUserHasPreferencesData(_local.value!.userId);
    return result;
  }

  @override
  void changeUserOnboardingState() {
    _local.updateOnboardingState(_local.value!.userId);
  }

  @override
  void clearUserLocalData() {
    _local.clearUserLocalData();
  }

  @override
  Future<void> updateUserChannelPreference(String channelId) {
    return _api.updateUserChannelPreference(
        userId: _local.userId!, channelId: channelId);
  }

  @override
  Future<void> updateUserGenrePreference(List<PreferredRequestContent> genres) {
    return _api.updateUserGenrePreference(
      userId: _local.userId!,
      genres: genres,
    );
  }
}
