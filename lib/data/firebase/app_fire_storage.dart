import 'package:firebase_storage/firebase_storage.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.0.2.25
 *  Firebase Storage Instance를 싱글톤으로 관리
 * */

class AppFireStorage {
  FirebaseStorage db = FirebaseStorage.instance;

  static FirebaseStorage get getInstance => Get.find<AppFireStorage>().db;
}
