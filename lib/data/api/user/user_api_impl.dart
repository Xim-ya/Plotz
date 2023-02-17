import 'package:soon_sak/data/api/user/user_api.dart';
import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';

class UserApiImpl with FirestoreHelper implements UserApi {
  @override
  Future<void> addUserQurationInfo(
      {required String qurationDocId, required String userId}) async {
    final Map<String, dynamic> curationList = {
      'data': db.collection('curation').doc(qurationDocId)
    };

    // 초기 값
    final Map<String, dynamic> curationSummary = {
      'completedCount': 0,
      'inProgressCount': 1,
      'onHoldCont': 0,
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
}
