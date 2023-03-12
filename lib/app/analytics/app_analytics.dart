import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.03.05
 * Firebase Analytics 인스턴를 전역으로 사용하는 모듈
 * */

class AppAnalytics {
  // AppAnalytics._();
  final FirebaseAnalytics _instance = FirebaseAnalytics.instance;

  static FirebaseAnalytics get instance => Get.find<AppAnalytics>()._instance;
}