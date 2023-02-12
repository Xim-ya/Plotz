import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

/** Created By Ximya - 2022.02.12
 *  Firebase Instance를 싱글톤으로 관리 관리
 * */

abstract class AppFireStore {
  AppFireStore._();

  FirebaseFirestore db = FirebaseFirestore.instance;

  static FirebaseFirestore get getInstance => Get.find<AppFireStore>().db;
}
