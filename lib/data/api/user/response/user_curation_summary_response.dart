import 'package:cloud_firestore/cloud_firestore.dart';

class UserCurationSummaryResponse {
  final int completedCount;
  final int inProgressCount;
  final int onHoldCount;

  UserCurationSummaryResponse({
    required this.completedCount,
    required this.inProgressCount,
    required this.onHoldCount,
  });

  factory UserCurationSummaryResponse.fromDoc(DocumentSnapshot snapshot) =>
      UserCurationSummaryResponse(
        completedCount: snapshot.get('completedCount'),
        inProgressCount: snapshot.get('inProgressCount'),
        onHoldCount: snapshot.get('onHoldCount'),
      );
}
