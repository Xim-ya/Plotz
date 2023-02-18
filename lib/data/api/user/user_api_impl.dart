
import 'package:soon_sak/utilities/index.dart';

class UserApiImpl with FirestoreHelper implements UserApi {
  @override
  Future<void> addUserCurationInfo(
      {required String qurationDocId, required String userId}) async {
    final Map<String, dynamic> curationList = {
      'data': db.collection('curation').doc(qurationDocId)
    };

    // 초기 값
    final Map<String, dynamic> curationSummary = {
      'completedCount': 0,
      'inProgressCount': 1,
      'onHoldCount': 0,
    };

    return storeAndUpdateDocumentAndSubCollection('user',
        docId: userId,
        data: curationList,
        firstSubCollectionName: 'curationList',
        firstSubCollectionData: curationList,
        firstSubCollectionDocId: qurationDocId,
        secondSubCollectionName: 'curationSummary',
        secondSubCollectionData: curationSummary,
        secondSubCollectionFieldName: 'inProgressCount');
  }

  @override
  Future<UserCurationSummaryResponse> loadUserCurationSummary(
      String userId) async {
    final snapshot = await getSingleSubCollectionDoc(
      'user',
      docId: userId,
      subCollectionName: 'curationSummary',
    );

    final doc = snapshot.docs;

    if (doc.isNotEmpty) {
      return UserCurationSummaryResponse.fromDoc(doc.single);
    } else {
      /// curation 내역이 없으면 초기값 전달
      return UserCurationSummaryResponse(
        completedCount: 0,
        inProgressCount: 0,
        onHoldCount: 0,
      );
    }
  }

  @override
  Future<List<CurationContentResponse>> loadUserCurationContentList(
      String userId) async {
    final docsRef = await getSubCollectionDocs(
      'user',
      docId: userId,
      subCollectionName: 'curationList',
    );

    final resultList = docsRef.map((e) async {
      final DocumentReference<Map<String, dynamic>> ref = e.get('data');
      final doc = await ref.get();
      return CurationContentResponse.fromUserResponseDoc(doc);
    }).toList();

    return Future.wait(resultList);
  }
}
