import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/data/firebase/app_fire_store.dart';

/** Created By Ximya - 2023.02.15
 *  FireStore 관련 네트워킹 메소드 기능을 관리하는 mixin 모듈
 * */

mixin FirestoreHelper {
  final _db = AppFireStore.getInstance;

  // 특정 id의 document 데이터를 불러오는 메소드
  Future<DocumentSnapshot> getDocFromId(String collectionName,
      {required String docId}) async {
    final ref = _db.collection(collectionName).doc(docId);
    final doc = await ref.get();
    return doc;
  }

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

  /// subCollection의 단일 document 데이터를 불러오는 메소드
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

  /// subCollection document 데이터 리스트를 불러오는 메소드
  Future<List<DocumentSnapshot>> getSubCollectionDocs(String collectionName,
      {required String docId, required String subCollectionName}) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .get();

    return snapshot.docs;
  }

  /// subCollection의 단일 document 데이터를 불러오는 메소드
  Future<QuerySnapshot> getSingleSubCollectionDoc(String collectionName,
      {required String docId, required String subCollectionName}) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .limit(1)
        .get();
    return snapshot;
  }

  /// subCollection의 특정 document 데이터를 불러오는 메소드
  Future<DocumentSnapshot> getSpecificSubCollectionDoc(String collectionName,
      {required String docId,
      required String subCollectionName,
      required String subCollectionDocId}) async {
    DocumentSnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .doc(subCollectionDocId)
        .get();

    return snapshot;
  }

  /// document를 생성하고 데이터를 저장하는 메소드
  Future<void> storeDocument(String collectionName,
      {required String? docId, required Map<String, dynamic> data}) {
    final docRef = _db.collection(collectionName).doc(docId);
    return docRef.set(data);
  }

  /// 특정 컬렉션의 document와 여러 subCollection document를
  /// 생성 및 저장하는 메소드
  /// subCollection의 경우
  /// 해당 subCollection이 기존에 존재 했을 경우 특정 필드 값을 increase하고
  /// 반대의 경우 기존 초기값(data)를 추가함
  Future<void> storeAndUpdateDocumentAndSubCollection(
    String collectionName, {
    required String docId,
    required Map<String, dynamic> data,
    required String firstSubCollectionName,
    required Map<String, dynamic> firstSubCollectionData,
    required String secondSubCollectionName,
    required Map<String, dynamic> secondSubCollectionData,
    required String secondSubCollectionFieldName,
    required String firstSubCollectionDocId,
  }) async {
    // document 생성 및 저장
    final docRef = _db.collection(collectionName).doc(docId);

    // Subcollection & subDocument 생성 및 저장
    // 1. Main Document
    final subCollectionRef =
        docRef.collection(firstSubCollectionName).doc(firstSubCollectionDocId);
    await subCollectionRef.set(firstSubCollectionData);

    // 2. Sub Document
    final CollectionReference secondSubCollectionRef =
        docRef.collection(secondSubCollectionName);
    final subCollectionDoc = await secondSubCollectionRef.limit(1).get();

    // subCollection이 기존에도 생성되어 있다면 특정 필드값 increase
    if (subCollectionDoc.docs.isNotEmpty) {
      print('// subCollection이 기존에도 생성되어 있다면 특정 필드값 increase');
      await secondSubCollectionRef
          .doc(subCollectionDoc.docs.single.id)
          .update({secondSubCollectionFieldName: FieldValue.increment(1)});
    } else {
      // 반대의 경우 subCollection을 생성하고 데이터를 추가 함.

      await secondSubCollectionRef.add(secondSubCollectionData);
    }
    return;
  }

  /// document를 생성하고 데이터를 저장하는 메소드
  //  생성한 document의 id값을 리턴함
  Future<String> storeDocumentAndReturnId(String collectionName,
      {required String? docId, required Map<String, dynamic> data}) async {
    final docRef = _db.collection(collectionName).doc(docId);
    await docRef.set(data);
    return docRef.id;
  }

  // 특정 subCollection의 dcoument 생성하고 데이터를 저장 하는 메소드
  Future<void> storeDocumentOnSubCollection(
    String collectionName, {
    required String subCollectionName,
    required String docId,
    required String subCollectionDocId,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .doc(subCollectionDocId);

    return docRef.set(data);
  }

  // 특정 field 값을 가지고 있는 document 리스트를 불러오는 메소드
  Future<List<DocumentSnapshot>> getDocsWithContainingField(
      String collectionName,
      {required String fieldName,
      required String neededFieldName}) async {
    final snapshot = await _db
        .collection(collectionName)
        .where(fieldName, isEqualTo: neededFieldName)
        .get();
    return snapshot.docs;
  }

  FirebaseFirestore get db => _db;
}
