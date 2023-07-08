import 'package:soon_sak/domain/useCase/channel/load_paged_channel_contents_use_case.dart';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ChannelApiImpl with FirestoreHelper implements ChannelApi {
  final _db = AppFireStore.getInstance;
  final TmdbRepository _tmdbRepository = locator<TmdbRepository>();

  @override
  Future<ChannelPagedResponse> loadPagedChannels(
      DocumentSnapshot? lastDocument) async {
    final docs = await getPagedDocuments('channel',
        pageSize: 10, lastDocument: lastDocument);

    return ChannelPagedResponse.fromDocument(docs);
  }

  @override
  Future<List<ChannelBasicResponse>> loadChannelSortedByContentCount() async {
    final docs = await getDocsByOrderWithLimit(
      'channel',
      orderFieldName: 'totalContent',
      limitCount: 20,
    );

    return docs.map((e) => ChannelBasicResponse.fromDocument(e)).toList();
  }

  @override
  Future<List<ChannelContentItemResponse>> loadPagedChannelContents(
      ChannelContentsRequest request) async {
    final docs = await getPagedDocumentsByFieldValue(
      'content',
      fieldName: 'channelRef',
      fieldValue: AppFireStore.getInstance.doc('/channel/${request.channelId}'),
      lastDocument: request.lastDocument,
      pageSize: LoadPagedChannelContentsUseCase.pageSize,
    );

    return docs.map((e) => ChannelContentItemResponse.fromDocument(e)).toList();
  }

  @override
  Future<ChannelBasicResponse> loadChannelById(String contentId) async {
    final doc = await getSubCollectionDoc(
      'content',
      docId: contentId,
      subCollectionName: 'channel',
      subCollectionDocId: 'main',
    );

    final DocumentReference<Map<String, dynamic>> docRef =
        doc.get('channelRef');
    final docData = await docRef.get();
    return ChannelBasicResponse.fromDocument(docData);
  }

  // @override
  // Future<void> setChannelField() async {
  //   // 채널 snapshot
  //   QuerySnapshot channelSnapshot = await _db.collection('channel').get();
  //
  //   // 채널 Documents
  //   List<DocumentSnapshot> channelDocs = channelSnapshot.docs;
  //
  //   // 채널 Documents loop
  //   await Future.forEach(channelDocs, (DocumentSnapshot e) async {
  //     // 콘텐츠 snapshot
  //     final contentSnapshot = await _db
  //         .collection('content')
  //         .where('channelRef',
  //             isEqualTo: AppFireStore.getInstance.doc('/channel/${e.id}'))
  //         .get();
  //
  //     // 콘텐츠 개수
  //     final contentsLength = contentSnapshot.docs.length;
  //     print('/channel/${e.id}');
  //     await updateDocumentFieldsTest(
  //       'channel',
  //       docId: e.id,
  //       firstFieldName: 'totalContent',
  //       firstFieldData: contentsLength,
  //     ).whenComplete(() => print("${e.id} 저장 완료"));
  //   });
  // }
  //
  // @override
  // Future<void> removeZeroContainedChannel() async {
  //   // 채널 snapshot
  //   QuerySnapshot channelSnapshot = await _db.collection('channel').get();
  //
  //   // 채널 Documents
  //   List<DocumentSnapshot> channelDocs = channelSnapshot.docs;
  //
  //   // 채널 Documents loop
  //   await Future.forEach(channelDocs, (DocumentSnapshot e) async {
  //     // 콘텐츠 snapshot
  //     final contentSnapshot = await _db
  //         .collection('content')
  //         .where('channelRef',
  //             isEqualTo: AppFireStore.getInstance.doc('/channel/${e.id}'))
  //         .get();
  //
  //     // 콘텐츠 개수
  //     final contentsLength = contentSnapshot.docs.length;
  //
  //     if (contentsLength == 0) {
  //       await deleteDocument('channel', docId: e.id);
  //       print("채널 삭제됨");
  //     }
  //   });
  // }
  //
  // /**
  //  * 1. Tv 콘텐츠만 불러온다
  //  * --> 중간에 tmdb 시즌정보 Call
  //  * 2. Tv 콘텐츠의 vidoe Subcollection에 접근한다
  //  * 3. 서브콜렉션이 'items' 필드값에 tmdb접근하여 tmdb 시즌 정보와 매핑
  //  * 4. 포스터 값 업데이트
  //  * */
  // @override
  // Future<void> updateSeasonContentField() async {
  //   // 콘텐츠 snapshot
  //   QuerySnapshot contents = await _db
  //       .collection('content')
  //       .where('id', isGreaterThanOrEqualTo: 't')
  //       .where('id', isLessThan: 'u')
  //       .get();
  //
  //   List<DocumentSnapshot> contentsDocs = contents.docs;
  //
  //   // 채널 Documents loop
  //   await Future.forEach(contentsDocs, (DocumentSnapshot e) async {
  //     // Tmdb 데이터
  //     final response = await _tmdbRepository
  //         .loadTmdbTvDetailResponse(SplittedIdAndType.fromOriginId(
  //       e.get('id'),
  //     ).id);
  //     final tmdbResult = response.getOrThrow();
  //
  //     DocumentSnapshot videoSubCollection = await _db
  //         .collection('content')
  //         .doc(e.id)
  //         .collection('video')
  //         .doc('main')
  //         .get();
  //
  //     final listRes = videoSubCollection.get('items') as List<dynamic>;
  //
  //     final videoItems = listRes
  //         .map<OldVideoResponse>((item) => OldVideoResponse.fromJson(item))
  //         .toList();
  //
  //     List<Map<String, dynamic>> arrayData = [];
  //
  //     for (var videoItem in videoItems) {
  //       SeasonInfo? seasonInfo = tmdbResult.seasonInfoList
  //           ?.firstWhere((ele) => ele.seasonNum == videoItem.order);
  //       print("선택된 seasonInfo ${seasonInfo!.seasonNum}");
  //
  //       arrayData.add({
  //         'order': videoItem.order,
  //         'videoId': videoItem.videoId,
  //         'posterImgUrl': seasonInfo.posterPathUrl,
  //         'overview': seasonInfo.description,
  //         'releaseDate': seasonInfo.airDate,
  //       });
  //     }
  //
  //     // 필드 업데이트
  //     await _db
  //         .collection('content')
  //         .doc(e.id)
  //         .collection('video')
  //         .doc('main')
  //         .update({'items': arrayData});
  //
  //     print('@@@@ ===> ${e.get('title')} 업데이트 완료');
  //   });
  //
  //   // 콘텐츠 개수
  //   //   final contentsLength = contentSnapshot.docs.length;
  //   //   print('/channel/${e.id}');
  //   //   await updateDocumentFieldsTest(
  //   //     'channel',
  //   //     docId: e.id,
  //   //     firstFieldName: 'totalContent',
  //   //     firstFieldData: contentsLength,
  //   //   ).whenComplete(() => print("${e.id} 저장 완료"));
  //   // });
  // }
  //
  // @override
  // Future<void> getTwoFace() async {
  //   // 채널 snapshot
  //   QuerySnapshot channelSnapshot = await _db.collection('channel').get();
  //
  //   // 채널 Documents
  //   List<DocumentSnapshot> channelDocs = channelSnapshot.docs;
  //
  //   // 채널 Documents loop
  //   await Future.forEach(channelDocs, (DocumentSnapshot e) async {
  //     // 콘텐츠 snapshot
  //     final contentSnapshot = await _db
  //         .collection('content')
  //         .where('channelRef',
  //             isEqualTo: AppFireStore.getInstance.doc('/channel/${e.id}'))
  //         .get();
  //
  //     // 콘텐츠 개수
  //     final contentsLength = contentSnapshot.docs.length;
  //     print('/channel/${e.id}');
  //     await updateDocumentFieldsTest(
  //       'channel',
  //       docId: e.id,
  //       firstFieldName: 'totalContent',
  //       firstFieldData: contentsLength,
  //     ).whenComplete(() => print("${e.id} 저장 완료"));
  //   });
  // }
  //
  // Future<void> checkUsercount() async {
  //   // 채널 snapshot
  //   QuerySnapshot channelSnapshot = await _db.collection('user').get();
  //
  //   // 채널 Documents
  //   List<DocumentSnapshot> channelDocs = channelSnapshot.docs;
  //
  //   print("유저 총 개수${channelDocs.length}");
  // }
  //
  // @override
  // Future<void> checkYC() async {
  //   final CollectionReference parentCollection =
  //       FirebaseFirestore.instance.collection('content');
  //   final QuerySnapshot parentSnapshot = await parentCollection.get();
  //
  //   int matchingDocumentsCount = 0;
  //
  //   for (final DocumentSnapshot parentDoc in parentSnapshot.docs) {
  //     final CollectionReference subcollection =
  //         parentDoc.reference.collection('channel');
  //     final QuerySnapshot subcollectionSnapshot = await subcollection.get();
  //
  //     if (subcollectionSnapshot.docs.isNotEmpty) {
  //       final DocumentSnapshot firstSubDoc = subcollectionSnapshot.docs[0];
  //       final dynamic desiredFieldValue =
  //           AppFireStore.getInstance.doc('/channel/UCRT4hxfWfXEP7Iiv3ovI-0A');
  //
  //       if (firstSubDoc.get('channelRef') == desiredFieldValue) {
  //         matchingDocumentsCount++;
  //       }
  //     }
  //   }
  // }
  //
  // // valid하지 채널을 가지고 있는 콘텐츠 모두 삭제
  // // UCn2yI8SFCCfRTHT7EFpUnmw
  // // UCrCV-T59Lrxf4yR3k_poiWw
  // Future<void> deleteDocumentsWithChannel( ) async {
  //   final dynamic desiredFieldValue =
  //   AppFireStore.getInstance.doc('/channel/UCrCV-T59Lrxf4yR3k_poiWw');
  //
  //   // 'content' 컬렉션에 대한 레퍼런스 가져오기
  //   CollectionReference contentCollection = FirebaseFirestore.instance.collection('content');
  //
  //   // 'content' 컬렉션의 모든 문서 가져오기
  //   QuerySnapshot snapshot = await contentCollection.get();
  //
  //   // 각 문서에 대해 작업 수행
  //   for (QueryDocumentSnapshot document in snapshot.docs) {
  //     // 현재 문서의 'channel' 컬렉션 레퍼런스 가져오기
  //     DocumentReference channelRef = document.reference.collection('channel').doc('main');
  //     print("진행중");
  //
  //     // 'channel' 컬렉션의 레퍼런스 값 가져오기
  //     DocumentSnapshot channelSnapshot = await channelRef.get();
  //     final channelValue = channelSnapshot.get('channelRef');
  //
  //     // 레퍼런스 값이 주어진 채널과 일치하는 경우 문서 제거
  //     if (channelValue == desiredFieldValue) {
  //       print("요건 잘못됨 ${document.get('title')}");
  //       print("요건 잘못됨 ${document.get('id')}");
  //       await document.reference.delete();
  //     }
  //   }
  // }
}
