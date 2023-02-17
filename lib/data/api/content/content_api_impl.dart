import 'package:soon_sak/utilities/index.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {
  @override
  Future<List<String>> loadTotalContentIdList() async {
    final aim = await getDocumentIdsFromCollection('content');
    return aim;
  }

  @override
  Future<List<BasicContentInfoResponse>> loadContainingIdsContents(
      List<String> ids) async {
    final documentSnapshots =
        await getContainingDocs(collectionName: 'content', ids: ids);

    return documentSnapshots
        .map(BasicContentInfoResponse.fromDocumentSnapshot)
        .toList();
  }

  @override
  Future<List<VideoResponse>> loadVideoInfo(String id) async {
    final documentSnapshots = await getFirstSubCollectionDoc(
      'content',
      docId: id,
      subCollectionName: 'video',
    );

    final listRes = documentSnapshots.get('items') as List<dynamic>;

    return listRes.map((e) => VideoResponse.fromJson(e)).toList();
  }

  @override
  Future<String> requestContentRegistration(ContentRequest requestData) {
    final Map<String, dynamic> data = requestData.toMap(
      curatorRef: db.collection('user').doc(requestData.curatorId),
    );
    return storeDocumentAndReturnId('curation', docId: null, data: data);
  }

  @override
  Future<void> addUserQurationInfo(
      {required String qurationDocId, required String userId}) async {
    final Map<String, dynamic> data = {
      'data': db.collection('curation').doc(qurationDocId)
    };

    return storeDocumentOnSubCollection(
      'user',
      subCollectionName: 'curationList',
      docId: userId,
      subCollectionDocId: qurationDocId,
      data: data,
    );
  }

  @override
  Future<List<InProgressCurationItemResponse>>
      loadInProgressQurationList() async {
    final docs = await getDocsWithContainingField('curation',
        fieldName: 'status', neededFieldName: 'inProgress');

    final resultList = docs.map((e) async {
      /// curator 필드는 참조 타입.
      /// 가리키고 있는 document의 데이터를 가져오는 기능을 수행해야함 (curator 필드)
      final DocumentReference<Map<String, dynamic>> curatorRef =
          e.get('curator');
      final curatorDoc = await curatorRef.get();
      final curatorName = await curatorDoc.get('name');
      final curatorImg = await curatorDoc.get('photoUrl');
      return InProgressCurationItemResponse.fromDocument(e, curatorName: curatorName, curatorImg: curatorImg);
    }).toList();

    return Future.wait(resultList);
  }
}
