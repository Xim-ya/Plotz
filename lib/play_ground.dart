// import 'package:soon_sak/utilities/index.dart';
//
// class ContentApiImpl with FirestoreHelper implements ContentApi {
//
//   @override
//   Future<void> updateContentInfo(ContentRequest content) async {
//     final Map<String, dynamic> data = {
//       "id" : content.id,
//       "title" : content.title,
//     };
//     updateDocumentField('content', docId: contentId, data: data);
// }
//
//   @override
//   Future<List<String>> loadTotalContentIdList() async {
//     final docs = await getDocumentIdsFromCollection('content');
//     return docs;
//   }
//
//   @override
//   Future<ChannelResponse> loadChannelInfo(String contentId) async {
//     final doc = await getSpecificSubCollectionDoc('content',
//         docId: contentId,
//         subCollectionName: 'channel',
//         subCollectionDocId: 'main');
//
//     final DocumentReference<Map<String, dynamic>> docRef =
//     doc.get('channelRef');
//     final docData = await docRef.get();
//     if (docData.exists) {
//       return ChannelResponse.fromDocumentRes(docData);
//     } else {
//       return ChannelResponse();
//     }
//   }
//
//
//
//
//
// }