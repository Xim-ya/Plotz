import 'package:soon_sak/domain/exception/user/response/user_curation_summary_response.dart';

abstract class UserApi {
  // 유저 큐레이션 정보 추가
  Future<void> addUserCurationInfo(
      {required String qurationDocId, required String userId});

  // 유저 큐레이션 요약 정보 호출
  Future<UserCurationSummaryResponse> loadUserCurationSummary(final String userId);
}