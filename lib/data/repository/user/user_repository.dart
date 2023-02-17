import 'package:soon_sak/utilities/index.dart';

abstract class UserRepository {

  // 유저 큐레이션 정보 추가
  Future<Result<void>> addUserQurationInfo(
      {required String qurationDocId, required String userId});
}