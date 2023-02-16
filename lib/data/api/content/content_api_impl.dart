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
  Future<void> requestContentRegistration(ContentRequest requestData) {
    final Map<String, dynamic> data = {
      'id': db.collection('users').doc(requestData.originId),
      'requestDate': FieldValue.serverTimestamp(),
      'title': requestData.title,
      'posterImgUrl': requestData.posterImgUrl,
      'curator': requestData.curatorId,
      'status': requestData.status,
      'videoID': requestData.videoId,
    };

    return storeDocument('curation', docId: null, data: data);
  }
}
