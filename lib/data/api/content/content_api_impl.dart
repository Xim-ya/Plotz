import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/extensions/determine_content_type.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentApiImpl with FirestoreHelper implements ContentApi {
  @override
  Future<List<String>> loadTotalContentIdList() async {
    final aim = await getDocumentIdsFromCollection('content');
    print(aim.length);
    return aim;
  }

  @override
  Future<List<OldVideoResponse>> oldLoadVideoInfo(String id) async {
    final documentSnapshots = await getFirstSubCollectionDoc(
      'content',
      docId: id,
      subCollectionName: 'video',
    );

    final listRes = documentSnapshots.get('items') as List<dynamic>;

    return listRes
        .map<OldVideoResponse>((item) => OldVideoResponse.fromJson(item))
        .toList();
  }

  @override
  Future<List<VideoResponse>> loadVideoInfo(
      {required String contentId, required ContentType contentType}) async {
    final documentSnapshots = await getFirstSubCollectionDoc(
      'content',
      docId: contentId,
      subCollectionName: 'video',
    );

    final listRes = documentSnapshots.get('items') as List<dynamic>;
    if (contentType.isMovie) {
      return listRes
          .map<VideoResponse>((item) => VideoResponse.fromMovieJson(item))
          .toList();
    } else {
      return listRes
          .map<VideoResponse>((item) => VideoResponse.fromTvMovieJson(item))
          .toList();
    }
  }

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(
    List<String> ids,
  ) async {
    final docs = await getContainingDocs(collectionName: 'content', ids: ids);

    final resultList = docs.map((e) async {
      /// channel  필드는 참조 타입.
      /// 가리키고 있는 document의 데이터를 가져오는 기능을 수행해야함 (channel 필드)
      final DocumentReference<Map<String, dynamic>> channelRef =
          e.get('channelRef');
      final channelDoc = await channelRef.get();

      return ExploreContentResponse.fromDocumentSnapshot(
        contentSnapshot: e,
        channelSnapshot: channelDoc,
      );
    }).toList();

    return Future.wait(resultList);
  }

  @override
  Future<void> requestContent(ContentRequest requestInfo) async {
    final data = requestInfo.toMap();
    await storeDocument(
      'requestContent',
      docId: requestInfo.contentId,
      data: data,
    );
  }

  @override
  Future<ChannelResponse> loadChannelInfo(String contentId) async {
    final doc = await getSubCollectionDoc(
      'content',
      docId: contentId,
      subCollectionName: 'channel',
      subCollectionDocId: 'main',
    );

    final DocumentReference<Map<String, dynamic>> docRef =
        doc.get('channelRef');
    final docData = await docRef.get();
    if (docData.exists) {
      return ChannelResponse.fromDocumentRes(docData);
    } else {
      return ChannelResponse();
    }
  }
}
