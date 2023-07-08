import 'package:firebase_storage/firebase_storage.dart';
import 'package:soon_sak/utilities/index_prev.dart';

/** Created By Ximya - 2023.0.2.25
 *  Firebase Storage Instance를 싱글톤으로 관리
 * */

abstract class AppFireStorage {
  AppFireStorage._();

  static final FirebaseStorage _db = FirebaseStorage.instance;

  static FirebaseStorage get getInstance => _db;
}

// class AppFireStorage {
//   FirebaseStorage db = FirebaseStorage.instance;
//
//   static FirebaseStorage get getInstance => Get.find<AppFireStorage>().db;
// }
