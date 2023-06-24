import 'package:hive_flutter/hive_flutter.dart';
import 'package:soon_sak/data/local/box/user/user_box.dart';

class UserDao {
  UserDao() {
    init();
  }

  late final Box<UserBox> box;

  UserBox? get value => box.values.firstOrNull;

  Future<void> init() async {
    box = await Hive.openBox<UserBox>('user');
  }

  Future<void> updateOnboardingState() async {
    await box.put(
      0,
      UserBox(isOnboardingProgressDone: false),
    );
  }
}
