import 'package:soon_sak/data/dto/content/content_api.dart';
import 'package:soon_sak/data/dto/content/response/basic_content_info_response.dart';
import 'package:soon_sak/data/dto/content/response/video_response.dart';
import 'package:soon_sak/data/mixin/fire_store_helper_mixin.dart';

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
}
