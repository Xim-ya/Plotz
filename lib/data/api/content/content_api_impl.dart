import 'package:soon_sak/utilities/index.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {
  @override
  Future<List<String>> loadTotalContentIdList() async {
    final aim = await getDocumentIdsFromCollection('content');
    return aim;
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
  Future<String> requestContentRegistration(
      ContentRegistrationRequest requestData) {
    final Map<String, dynamic> data = requestData.toMap(
      curatorRef: db.collection('user').doc(requestData.curatorId),
    );
    return storeDocumentAndReturnId('curation', docId: null, data: data);
  }

  @override
  Future<List<CurationContentResponse>> loadInProgressQurationList() async {
    final docs = await getDocsWithContainingField('curation',
        fieldName: 'status', neededFieldName: 'inProgress');

    final resultList = docs.map((e) async {
      /// curator 필드는 참조 타입.
      /// 가리키고 있는 document의 데이터를 가져오는 기능을 수행해야함 (curator 필드)
      final DocumentReference<Map<String, dynamic>> curatorRef =
          e.get('curator');
      final curatorDoc = await curatorRef.get();
      final String? curatorName = curatorDoc.data()?['displayName'];
      final String? curatorImg = curatorDoc.data()?['photoUrl'];
      return CurationContentResponse.fromDocument(e,
          curatorName: curatorName, curatorImg: curatorImg);
    }).toList();

    return Future.wait(resultList);
  }

  @override
  Future<UserResponse> loadCuratorInfo(String contentId) async {
    final doc = await getSpecificSubCollectionDoc('content',
        docId: contentId,
        subCollectionName: 'curator',
        subCollectionDocId: 'main');

    final DocumentReference<Map<String, dynamic>> docRef = doc.get('userRef');
    final docData = await docRef.get();
    if (docData.exists) {
      return UserResponse.fromDocumentRes(docData);
    } else {
      return UserResponse();
    }
  }

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(
      List<String> ids) async {
    final docs = await getContainingDocs(collectionName: 'content', ids: ids);

    final resultList = docs.map((e) async {
      /// channel  필드는 참조 타입.
      /// 가리키고 있는 document의 데이터를 가져오는 기능을 수행해야함 (channel 필드)
      final DocumentReference<Map<String, dynamic>> channelRef =
          e.get('channelRef');
      final channelDoc = await channelRef.get();

      return ExploreContentResponse.fromDocumentSnapshot(
          contentSnapshot: e, channelSnapshot: channelDoc);
    }).toList();

    return Future.wait(resultList);
  }

  @override
  Future<void> requestContent(ContentRequest requestInfo) async {
    final data = requestInfo.toMap();
    await storeDocument('requestContent', docId: null, data: data);
  }
}
