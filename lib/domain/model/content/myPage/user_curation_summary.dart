import 'package:soon_sak/data/api/user/response/user_curation_summary_response.dart';

class UserCurationSummary {
  final int completedCount;
  final int inProgressCount;
  final int onHoldCount;

  UserCurationSummary({
    required this.completedCount,
    required this.inProgressCount,
    required this.onHoldCount,
  });

  factory UserCurationSummary.fromResponse(
          UserCurationSummaryResponse response,) =>
      UserCurationSummary(
        completedCount: response.completedCount,
        inProgressCount: response.inProgressCount,
        onHoldCount: response.onHoldCount,
      );
}
