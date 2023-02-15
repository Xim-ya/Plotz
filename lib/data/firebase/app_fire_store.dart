import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.02.12
 *  Firebase Instance를 싱글톤으로 관리 관리
 * */

class AppFireStore {
  FirebaseFirestore db = FirebaseFirestore.instance;

  static FirebaseFirestore get getInstance => Get.find<AppFireStore>().db;
}
