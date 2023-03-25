// import 'package:soon_sak/utilities/index.dart';
//
// class ContentApi  {
//   final FirestoreHelper helper = FirestoreHelper();
//
//   Future<void> updateContentInfo(ContentRequest content) {
//     final Map<String, dynamic> data = {
//       'id': content.id,
//       'title': content.title,
//     };
//     return helper.updateDocumentField('content', docId: content.contentId, data: data);
//   }
//
//   Future<List<String>> loadTotalContentIdList() async {
//     final docIdList = await helper.getDocumentIdsFromCollection('content');
//     return docIdList;
//   }
//
//   Future<ChannelResponse> loadChannelInfo(String contentId) async {
//     final doc = await helper.getSubCollectionDoc('content',
//         docId: contentId,
//         subCollectionName: 'channel',
//         subCollectionDocId: 'main');
//
//     final DocumentReference<Map<String, dynamic>> docRef =
//     doc.get('channelRef');
//     final docData = await docRef.get();
//     return ChannelResponse.fromDocumentRes(docData);
//   }
// }
