// import 'dart:developer';
//
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:get/get.dart';
//
// class SecureStorage extends GetxService {
//   // Create storage
//   late FlutterSecureStorage storage;
//
//   Future<void> _initStorage() async {
//     storage = new FlutterSecureStorage();
//   }
//
//   // 데이터 조회
//   Future<void> getData({required String key}) async {
//     try {
//       String? value = await storage.read(key: key);
//       print(value);
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future<void> writeData({required String key, required String data}) async {
//     try {
//       await storage.write(key: key, value: data);
//     } catch (e) {
//       print(e.toString());
//     }
//   }
//
//   @override
//   void onInit() {
//     super.onInit();
//     _initStorage();
//   }
// }
