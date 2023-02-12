import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uppercut_fantube/data/firebase/app_fire_store.dart';

mixin FirestoreHelper {
  final db = AppFireStore.getInstance;

  // Collection에서 속한 Document ID List를 불러오는 메소드
  Future<List<String>> getDocumentIdsFromCollection(
      String collectionName) async {
    List<String> documentIds = [];
    QuerySnapshot snapshot = await db.collection(collectionName).get();
    for (var document in snapshot.docs) {
      documentIds.add(document.id);
    }
    return documentIds;
  }

  // 특정 Array에서 10개의 무작위 데이터를 불러오는 메소드
  Future<List<String>> getRandomArrayElements() async {
    final List<String> documentIds =
        await getDocumentIdsFromCollection('contents');
    final random = Random();
    final result = <String>[];
    for (int i = 0; i < 10; i++) {
      result.add(documentIds[random.nextInt(documentIds.length)]);
    }
    return result;
  }
}
