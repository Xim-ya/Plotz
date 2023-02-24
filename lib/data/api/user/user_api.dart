
import 'package:soon_sak/utilities/index.dart';

abstract class UserApi {
  // 유저 큐레이션 정보 추가
  Future<void> addUserCurationInfo(
      {required String qurationDocId, required String userId});

  // 유저 큐레이션 요약 정보 호출
  Future<UserCurationSummaryResponse> loadUserCurationSummary(
      final String userId);

  // 유저의 큐레이션 리스트 호출
  Future<List<CurationContentResponse>> loadUserCurationContentList(
    String userId,
  );

  // 유저 시청 기록 추가
  Future<void> addUserWatchHistory(WatchingHistoryRequest requestInfo);
}
