import 'package:hive/hive.dart';

part 'user_box.g.dart';

@HiveType(typeId: 0)
class UserBox {
  @HiveField(0, defaultValue: false)
  final bool isOnboardingProgressDone;

  UserBox({required this.isOnboardingProgressDone});
}
