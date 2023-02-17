import 'package:soon_sak/domain/model/content/myPage/user_curation_summary.dart';
import 'package:soon_sak/utilities/index.dart';

abstract class UserRepository {
  // 유저 큐레이션 정보 추가
  Future<Result<void>> addUserQurationInfo(
      {required String qurationDocId, required String userId});

  // 유저 큐레이션 요약 정보 호출
  Future<Result<UserCurationSummary>> loadUserCurationSummary(final String userId);
}
