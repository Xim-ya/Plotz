import 'package:soon_sak/data/api/user/user_api.dart';
import 'package:soon_sak/data/mixin/fire_store_error_handler_mixin.dart';

abstract class UserDataSource {

  // 유저 큐레이션 정보 추가
  Future<void> addUserQurationInfo(
      {required String qurationDocId, required String userId});
}