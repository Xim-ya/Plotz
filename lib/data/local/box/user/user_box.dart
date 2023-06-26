import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox {
  @HiveField(0)
  final String userId;

  @HiveField(1, defaultValue: false)
  final bool isOnboardingProgressDone;

  UserBox({required this.userId, required this.isOnboardingProgressDone});
}
