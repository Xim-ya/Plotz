import 'package:uppercut_fantube/data/dto/content/content_api.dart';
import 'package:uppercut_fantube/data/dto/content/response/basic_content_info_response.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_helper_mixin.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {
  @override
  Future<List<String>> loadTotalContentIdList() async{

    final aim = await  getDocumentIdsFromCollection('content');
    print('arang 입니다 ${aim.length}');
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
}
