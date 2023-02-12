import 'package:uppercut_fantube/data/dto/content/content_api.dart';
import 'package:uppercut_fantube/data/dto/content/response/basic_content_info_response.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_helper_mixin.dart';
import 'package:uppercut_fantube/domain/service/content_service.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {
  @override
  Future<List<String>> loadTotalContentIdList() {
    return getDocumentIdsFromCollection('content');
  }

  @override
  Future<List<BasicContentInfoResponse>> loadContainingIdsContents(
      List<String> ids) async {


    print("전달 받은 아이디 리스트 $ids");
    final documentSnapshots =
        await getContainingDocs(collectionName: 'content', ids: ids);

    return documentSnapshots
        .map(BasicContentInfoResponse.fromDocumentSnapshot)
        .toList();
  }
}
