import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreContentResponse {
  final String id;
  final String title;
  final String videoTitle;
  final String channelName;
  final String channelLogoImgUrl;
  final String releaseDate;
  final String posterImgUrl;
  final int subscribersCount;

  ExploreContentResponse({
    required this.channelName,
    required this.subscribersCount,
    required this.channelLogoImgUrl,
    required this.id,
    required this.title,
    required this.videoTitle,
    required this.releaseDate,
    required this.posterImgUrl,
  });

  factory ExploreContentResponse.fromDocumentSnapshot(
      {required DocumentSnapshot<Object?> contentSnapshot,
      required DocumentSnapshot<Object?> channelSnapshot,}) {
    return ExploreContentResponse(
        id: contentSnapshot.get('id'),
        title: contentSnapshot.get('title'),
        releaseDate: contentSnapshot.get('releaseDate'),
        posterImgUrl: contentSnapshot.get('posterImgUrl'),
        channelLogoImgUrl: channelSnapshot.get('logoImgUrl'),
        channelName: channelSnapshot.get('name'),
        videoTitle: contentSnapshot.get('videoTitle'),
        subscribersCount: channelSnapshot.get('subscribersCount'),);
  }
}
