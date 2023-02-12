import 'package:uppercut_fantube/data/dto/content/content_api.dart';
import 'package:uppercut_fantube/data/mixin/fire_store_helper_mixin.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {

  @override
  Future<List<String>> loadTotalContentIdList() {
    return getDocumentIdsFromCollection('content');
  }
}
