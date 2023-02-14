import 'dart:async';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:soon_sak/firebase_options.dart';

mixin FirestoreIsolateMixin {
  // Firestore 인스턴스 생성
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  // Firestore 쿼리를 실행하고 결과를 반환하는 메소드
  Future<List<QueryDocumentSnapshot>> getContainingDocsInIsolate(String collectionPath,
      {required List<String> ids}) async {
    // Isolate 생성
    final Completer<List<QueryDocumentSnapshot>> completer = Completer();
    final ReceivePort receivePort = ReceivePort();
    final Isolate isolate = await Isolate.spawn(
      _isolateFunction,
      [
        collectionPath,
        ids,
        receivePort.sendPort,
      ],
    );

    // SendPort로 Firestore 쿼리 실행 요청
    receivePort.listen((dynamic result) {
      completer.complete(result as List<QueryDocumentSnapshot>);
      receivePort.close();
      isolate.kill();
    });
    return completer.future;
  }

  // Firestore 쿼리를 실행하는 isolate 함수
  static void _isolateFunction(List<dynamic> message) async {
    print("arang 123");
    // message 리스트는 [collectionPath, query, limit, startAfter, sendPort] 형태입니다.
    final String collectionPath = message[0] as String;
    final List<String> passedWhereInIds = message[1] as List<String>;
    final SendPort sendPort = message[2] as SendPort;

    await Firebase.initializeApp(
      name: 'soonsak-15350',
      options: DefaultFirebaseOptions.currentPlatform,
    );

    // Firestore 쿼리 실행
    QuerySnapshot querySnapshot;
    querySnapshot = await FirebaseFirestore.instance
        .collection(collectionPath)
        .where('id', whereIn: passedWhereInIds)
        .get();
    // 결과 SendPort로 전송
    final List<QueryDocumentSnapshot> result = querySnapshot.docs;
    sendPort.send(result);
  }
}