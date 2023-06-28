import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:soon_sak/data/firebase/app_fire_store.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.15
 *  FireStore 관련 네트워킹 메소드 기능을 관리하는 mixin 모듈
 * */

mixin FirestoreHelper {
  final _db = AppFireStore.getInstance;

  // 특정 id의 document 데이터를 불러오는 메소드
  Future<DocumentSnapshot> getDocById(
    String collectionName, {
    required String docId,
  }) async {
    final ref = _db.collection(collectionName).doc(docId);
    final doc = await ref.get();
    return doc;
  }

  // Collection에서 속한 Document ID List를 불러오는 메소드
  Future<List<String>> getDocumentIdsFromCollection(
    String collectionName,
  ) async {
    List<String> documentIds = [];
    QuerySnapshot snapshot = await _db.collection(collectionName).get();
    for (var document in snapshot.docs) {
      documentIds.add(document.id);
    }
    return documentIds;
  }

  // 특정 필드 값

  // 특정 필드 값을 가지고 있는 documents를 가져오는 메소드
  Future<List<DocumentSnapshot>> getPagedDocumentsByFieldValue(
      String collectionName,
      {required String fieldName,
      required dynamic fieldValue,
      required int pageSize,
      required DocumentSnapshot? lastDocument}) async {
    if (lastDocument.hasData) {
      QuerySnapshot snapshot = await _db
          .collection(collectionName)
          .where(fieldName, isEqualTo: fieldValue)
          .limit(pageSize)
          .startAfterDocument(lastDocument!)
          .get();
      return snapshot.docs;
    } else {
      QuerySnapshot snapshot = await _db
          .collection(collectionName)
          .where(fieldName, isEqualTo: fieldValue)
          .limit(pageSize)
          .get();
      return snapshot.docs;
    }
  }

  /// 주어진 id List에 해당하는 Document 데이터를 불러오는 메소도
  /// FireStore where In 인덱싱 쿼리 메소드는
  /// 10개의 제한이 있기 때문에
  /// 전달 받은 [ids] 10개 단위로 나누어 호출
  Future<List<DocumentSnapshot>> getContainingDocs({
    required String collectionName,
    required List<String> ids,
  }) async {
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

  /// subCollection의 첫 번쟤 단일 document 데이터를 불러오는 메소드
  Future<QueryDocumentSnapshot> getFirstSubCollectionDoc(
    String collectionName, {
    required String docId,
    required String subCollectionName,
  }) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .limit(1)
        .get();

    return snapshot.docs.first;
  }

  /// paged 방식으로 collection의 documents 데이터를 가져오는 메소드
  Future<List<DocumentSnapshot>> getPagedDocuments(String collectionName,
      {required int pageSize, required DocumentSnapshot? lastDocument}) async {
    if (lastDocument.hasData) {
      QuerySnapshot snapshot = await _db
          .collection(collectionName)
          .limit(pageSize)
          .startAfterDocument(lastDocument!)
          .get();
      return snapshot.docs;
    } else {
      QuerySnapshot snapshot =
          await _db.collection(collectionName).limit(pageSize).get();
      return snapshot.docs;
    }
  }

  /// subCollection document 데이터 리스트를 불러오는 메소드
  Future<List<DocumentSnapshot>> getSubCollectionDocs(
    String collectionName, {
    required String docId,
    required String subCollectionName,
  }) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .get();

    return snapshot.docs;
  }

  // collection document 데이터 리스트를 불러오는 메소드
  // 특정 필드값을 기준으로 정렬됨
  // 최대 불러올 수 있는 데이터 개수가 정해져 있음
  Future<List<DocumentSnapshot>> getDocsByOrderWithLimit(
    String collectionName, {
    required String orderFieldName,
    required int limitCount,
  }) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .orderBy(orderFieldName, descending: true)
        .limit(limitCount)
        .get();
    return snapshot.docs;
  }

  /// subCollection document 데이터 리스트를 불러오는 메소드
  /// 특정 필드값을 기준으로 정렬됨
  Future<List<DocumentSnapshot>> getSubCollectionDocsByOrder(
    String collectionName, {
    required String docId,
    required String subCollectionName,
    required String orderFieldName,
  }) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .orderBy(orderFieldName, descending: true)
        .get();

    return snapshot.docs;
  }

  /// dcoumentID 변경
  Future<void> changeDocId(
    String collectionName, {
    required String docId,
  }) async {
    DocumentSnapshot<Map<String, dynamic>> oldDocumentSnapshot =
        await _db.collection(collectionName).doc(docId).get();

    final prevData = oldDocumentSnapshot.data()!;
    prevData['withdrawnDate'] = FieldValue.serverTimestamp();
    await _db.collection(collectionName).doc('WITHDRAWN-$docId').set(prevData);
    await _db.collection(collectionName).doc(docId).delete();
  }

  /// subCollection의 단일 document 데이터를 불러오는 메소드
  Future<QuerySnapshot> getSingleSubCollectionDoc(
    String collectionName, {
    required String docId,
    required String subCollectionName,
  }) async {
    QuerySnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .limit(1)
        .get();
    return snapshot;
  }

  // collection의 dcoument리스트 중 특정 필드 값 데이터를 포함하고 있는지 확인
  Future<bool> checkIfItContainField(
    String collectionName, {
    required String fieldName,
    required String data,
  }) async {
    final querySnapshot = await _db
        .collection(collectionName)
        .where(fieldName, isEqualTo: data)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  /// 특정 필드값을 업데이트 하는 메소드
  /// 최대 2개의 필드 값을 업데이트할 수 있고
  /// 두 번째 필드 값 정보가 없다면
  /// 첫 번째 필드 값에 해당하는 정보만 업데이트
  Future<void> updateDocumentFields(
    final String collectionName, {
    required String docId,
    String? firstFieldName,
    String? firstFieldData,
    String? secondFieldName,
    String? secondFieldData,
  }) async {
    final docRef = _db.collection(collectionName).doc(docId);
    if (firstFieldData == null) {
      await docRef.update({secondFieldName!: secondFieldData});
    } else if (secondFieldData == null) {
      await docRef.update({firstFieldName!: firstFieldData});
    } else {
      await docRef.update(
        {firstFieldName!: firstFieldData, secondFieldName!: secondFieldData},
      );
    }
  }

  /// 특정 필드값을 업데이트 하는 메소드
  /// 최대 2개의 필드 값을 업데이트할 수 있고
  /// 두 번째 필드 값 정보가 없다면
  /// 첫 번째 필드 값에 해당하는 정보만 업데이트
  Future<void> updateDocumentFieldsTest(
    final String collectionName, {
    required String docId,
    String? firstFieldName,
    dynamic firstFieldData,
    String? secondFieldName,
    dynamic secondFieldData,
  }) async {
    final docRef = _db.collection(collectionName).doc(docId);
    if (firstFieldData == null) {
      await docRef.update({secondFieldName!: secondFieldData});
    } else if (secondFieldData == null) {
      await docRef.update({firstFieldName!: firstFieldData});
    } else {
      await docRef.update(
        {firstFieldName!: firstFieldData, secondFieldName!: secondFieldData},
      );
    }
  }

  /// subCollection의 특정 document 데이터를 불러오는 메소드
  Future<DocumentSnapshot> getSubCollectionDoc(
    String collectionName, {
    required String docId,
    required String subCollectionName,
    required String subCollectionDocId,
  }) async {
    DocumentSnapshot snapshot = await _db
        .collection(collectionName)
        .doc(docId)
        .collection(subCollectionName)
        .doc(subCollectionDocId)
        .get();

    return snapshot;
  }

  /// document를 생성하고 데이터를 저장하는 메소드
  Future<void> storeDocument(
    String collectionName, {
    required String? docId,
    required Map<String, dynamic> data,
  }) {
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
      await secondSubCollectionRef
          .doc(subCollectionDoc.docs.single.id)
          .update({secondSubCollectionFieldName: FieldValue.increment(1)});
    } else {
      // 반대의 경우 subCollection을 생성하고 데이터를 추가 함.

      await secondSubCollectionRef.add(secondSubCollectionData);
    }
    return;
  }

  //  특정 document 삭제
  Future<void> deleteDocument(String collectionName, {required String docId}) {
    return _db.collection(collectionName).doc(docId).delete();
  }

  /// document를 생성하고 데이터를 저장하는 메소드
  //  생성한 document의 id값을 리턴함
  Future<String> storeDocumentAndReturnId(
    String collectionName, {
    required String? docId,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _db.collection(collectionName).doc(docId);
    await docRef.set(data);
    return docRef.id;
  }

  // 특정 Document에 데이터를 업데이트 하는 메소드
  Future<void> updateDocumentField(
    String collectionName, {
    required String? docId,
    required Map<String, dynamic> data,
  }) async {
    final docRef = _db.collection(collectionName).doc(docId);
    await docRef.update(data);
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

  // SubCollection Document의 존재 여부를 확인하고
  // 특정 필드값의 필드를 업데이트 or 새로운 document 생성 (CREATE or UPDATE)
  // 해당 subCollection doucment 개수가 20개가 넘는다면
  // 특정 필드값의 데이터를 기준으로 정렬하여 마지막 document를 삭제 (DELETE)
  Future<void> cudSubCollectionDocumentWithLimit(
    String collectionName, {
    required String docId,
    required String subCollectionName,
    required String subCollectionDocId,
    required String firstMutableFieldName,
    required String secondMutableFieldName,
    required Map<String, dynamic> data,
  }) async {
    final CollectionReference collectionRef = _db.collection(collectionName);
    final DocumentReference documentRef = collectionRef.doc(docId);
    final CollectionReference subCollectionRef =
        documentRef.collection(subCollectionName);
    final DocumentReference subCollectionDocRef =
        subCollectionRef.doc(subCollectionDocId);

    // 기존 Doucment 존재 여부
    final bool documentExists =
        await _db.runTransaction<bool>((transaction) async {
      final DocumentSnapshot snapshot =
          await transaction.get(subCollectionDocRef);

      // 존재한다면 특정 필드값 업데이트
      if (snapshot.exists) {
        transaction.update(subCollectionDocRef, {
          firstMutableFieldName: Timestamp.now(),
          secondMutableFieldName: data['videoId']
        });
      } else {
        // 존재 하지 않는다면 새로운 Document 추가
        transaction.set(subCollectionDocRef, data);
      }
      return snapshot.exists;
    });

    if (!documentExists) {
      final QuerySnapshot querySnapshot = await subCollectionRef
          .orderBy(firstMutableFieldName, descending: true)
          .get();

      // collection의 Document document 개수가 20개가 넘는다면
      // 마지막 document를 삭제
      if (querySnapshot.docs.length > 20) {
        final DocumentSnapshot oldestDocument = querySnapshot.docs.last;
        await oldestDocument.reference.delete();
      }
    }
  }

  // [UNIQUE ONE] 유저 콘텐츠 선호
  // SubCollection Document의 존재 여부를 확인하고
  // 특정 필드값의 필드를 업데이트 or 새로운 document 생성 (CREATE or UPDATE)
  // 업데이트 해야되는 상황이라면 필드값만 업데이트
  Future<void> cudSubCollectionDocumentAndIncreaseIntFields(
    String collectionName, {
    required String docId,
    required String subCollectionName,
    required String subCollectionDocId,
    required int fieldValue,
    required String fieldName,
    required Map<String, dynamic> data,
  }) async {
    final CollectionReference collectionRef = _db.collection(collectionName);
    final DocumentReference documentRef = collectionRef.doc(docId);
    final CollectionReference subCollectionRef =
        documentRef.collection(subCollectionName);
    final DocumentReference subCollectionDocRef =
        subCollectionRef.doc(subCollectionDocId);

    await _db.runTransaction((transaction) async {
      final DocumentSnapshot snapshot =
          await transaction.get(subCollectionDocRef);

      // 존재한다면 특정 필드값 업데이트
      if (snapshot.exists) {
        transaction.update(subCollectionDocRef, {
          fieldName: snapshot.get('count') + fieldValue,
        });
      } else {
        // 존재 하지 않는다면 새로운 Document 추가
        transaction.set(subCollectionDocRef, data);
      }
    });
  }

  // 특정 collection에 subCollection 자체가 존재하는지 확인
  Future<bool> checkSubCollectionExist(
    String collectionName, {
    required String docId,
    required String subCollectionName,
  }) async {
    final CollectionReference collectionRef = _db.collection(collectionName);
    final DocumentReference documentRef = collectionRef.doc(docId);
    final CollectionReference subCollectionRef =
        documentRef.collection(subCollectionName);

    final QuerySnapshot subCollectionSnapshot =
        await subCollectionRef.limit(1).get();

    return subCollectionSnapshot.docs.isNotEmpty;
  }

  // 특정 field 값을 가지고 있는 document 리스트를 불러오는 메소드
  Future<List<DocumentSnapshot>> getDocsWithContainingField(
    String collectionName, {
    required String fieldName,
    required String neededFieldName,
  }) async {
    final snapshot = await _db
        .collection(collectionName)
        .where(fieldName, isEqualTo: neededFieldName)
        .get();
    return snapshot.docs;
  }

  FirebaseFirestore get db => _db;
}
