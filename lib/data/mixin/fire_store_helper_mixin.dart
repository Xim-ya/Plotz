import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/data/firebase/app_fire_store.dart';

mixin FirestoreHelper {
  final _db = AppFireStore.getInstance;

  // Collection에서 속한 Document ID List를 불러오는 메소드
  Future<List<String>> getDocumentIdsFromCollection(
      String collectionName) async {
    List<String> documentIds = [];
    QuerySnapshot snapshot = await _db.collection(collectionName).get();
    for (var document in snapshot.docs) {
      documentIds.add(document.id);
    }
    return documentIds;
  }

  /// 주어진 id List에 해당하는 Document 데이터를 불러오는 메소도
  /// FireStore where In 인덱싱 쿼리 메소드는
  /// 10개의 제한이 있기 때문에
  /// 전달 받은 [ids] 10개 단위로 나누어 호출
  Future<List<DocumentSnapshot>> getContainingDocs(
      {required String collectionName, required List<String> ids}) async {
    List<DocumentSnapshot> results = [];

    List<List<String>> idChunks = [];
    for (int i = 0; i < ids.length; i += 10) {
      int end = i + 10;
      if (end > ids.length) end = ids.length;
      idChunks.add(ids.sublist(i, end));
    }

    for (List<String> idChunk in idChunks) {
      QuerySnapshot snapshot = await _db
          .collection(collectionName)
          .where('id', whereIn: idChunk)
          .get();
      results.addAll(snapshot.docs);
    }

    return results;
  }

  /// subCollection의 document 데이터를 불러오는 메소드
  Future<QueryDocumentSnapshot> getFirstSubCollectionDoc(String collectionName,
      {required String docId, required String subCollectionName}) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .limit(1)
        .get();

    return snapshot.docs.first;
  }
}
