import 'package:soon_sak/utilities/index.dart';

abstract class UserRepository {
  // 유저 큐레이션 정보 추가
  Future<Result<void>> addUserQurationInfo(
      {required String qurationDocId, required String userId});

  // 유저 큐레이션 요약 정보 호출
  Future<Result<UserCurationSummary>> loadUserCurationSummary(final String userId);

  // 유저의 큐레이션 리스트 호출
  Future<Result<List<CurationContent>>> loadUserCurationContentList(String userId);

  // 유저 시청 기록 추가
  Future<Result<void>> addUserWatchHistory(WatchingHistoryRequest requestInfo);

}
