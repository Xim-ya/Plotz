import 'package:hive_flutter/hive_flutter.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';

class UserDao {
  UserDao() {
    init();
  }

  late final Box<UserBox> box;

  UserBox? get value => box.values.firstOrNull;

  String? get userId => value?.userId;

  // DAO 초기화
  Future<void> init() async {
    box = await Hive.openBox<UserBox>('user');
  }

  /// 유저 온보딩 여부값 업데이트 (boolean)
  Future<void> updateOnboardingState(String userId) async {
    await box.put(
      'user',
      UserBox(
        isOnboardingProgressDone: true,
        userId: userId,
      ),
    );
  }

  // 유저 아이디 값 업데이트
  Future<void> updateUserId(String userId) async {
    await box.put(
      'user',
      UserBox(
          userId: userId,
          isOnboardingProgressDone: value?.isOnboardingProgressDone ?? false),
    );
  }

  // 유저 로컬 데이터 삭제
  void clearUserLocalData() {
    box.clear();
  }
}
