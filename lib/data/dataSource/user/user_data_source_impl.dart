import 'dart:io';
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
  Future<void> addUserCurationInfo({
    required String curationDocId,
    required String userId,
  }) =>
      loadResponseOrThrow(
        () => _api.addUserCurationInfo(
          curationDocId: curationDocId,
          userId: userId,
        ),
      );

  @override
  Future<UserCurationSummaryResponse> loadUserCurationSummary(String userId) =>
      loadResponseOrThrow(() => _api.loadUserCurationSummary(userId));

  @override
  Future<List<CurationContentResponse>> loadUserCurationContentList(
    String userId,
  ) async {
    return loadResponseOrThrow(() => _api.loadUserCurationContentList(userId));
  }

  @override
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo) {
    return loadResponseOrThrow(
      () => _api.addUserWatchHistory(requestInfo),
    );
  }

  @override
  Future<List<UserWatchHistoryItemResponse?>> loadUserWatchHistory(
    String userId,
  ) =>
      loadResponseOrThrow(
            () => _api.loadUserWatchHistory(userId),
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
  Future<String> uploadUserProfileImgAndReturnUrl({
    required String userId,
    required File file,
  }) {
    return loadResponseOrThrow(
      () => _api.uploadUserProfileImgAndReturnUrl(userId: userId, file: file),
    );
  }

  @override
  Future<void> withdrawUser(String userId) async =>
      loadResponseOrThrow(() => _api.withdrawUser(userId));

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
  Future<bool> checkIfUserHasPreferencesData(String userId) async {
    // final userId = _local.userId;
    // if (userId == null) return Future.value(false);
    final result = _api.checkIfUserHasPreferencesData(userId);
    return result;
  }

  @override
  void changeUserOnboardingState(String userId) {
    _local.updateOnboardingState(userId);
  }

  @override
  void clearUserLocalData() {
    _local.clearUserLocalData();
  }
}
