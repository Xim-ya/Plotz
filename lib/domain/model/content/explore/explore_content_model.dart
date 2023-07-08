import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ExploreContentModel with FirestoreHelper {
  final List<ExploreContentItem> contents;

  ExploreContentModel({required this.contents});

  factory ExploreContentModel.fromResponse(
    List<BasicContentInfoResponse> response,
  ) {
    final List<BasicContentInfoResponse> shuffledList = response;
    shuffledList.shuffle();

    return ExploreContentModel(
      contents: shuffledList.map(ExploreContentItem.fromResponse).toList(),
    );
  }

  /* Intents */
  // 유튜브 정보 업데이트
  Future<void> updateYoutubeChannelInfo() async {
    for (var e in contents) {
      final channelRes =
          await YoutubeMetaData.yt.channels.getByVideo(e.videoId);
      final videoRes = await YoutubeMetaData.yt.videos.get(e.videoId);
      e.youtubeInfo = ExploreContentYoutubeInfo.fromResponse(
        channelRes: channelRes,
        videoRes: videoRes,
      );

      final String channelId = channelRes.id.value;

      Map<String, dynamic> data = {
        'channelRef': db.collection('channel').doc(channelId)
      };

      await storeDocumentAndReturnId('content', docId: e.originId, data: data);

      print(
        'contentId : ${e.originId} / channelName : ${channelRes.title} / channelProfileImage :${channelRes.logoUrl}   / channelId ${channelRes.id} / videoTitle ${videoRes.title} / subscribersCount ${channelRes.subscribersCount}',
      );
    }
  }
}

class ExploreContentItem {
  final String originId;
  final int id;
  final ContentType type;
  final String videoId;
  final String title;
  final String releaseDate;
  final String posterImgUrl;
  late ExploreContentYoutubeInfo? youtubeInfo; // 컨텐츠 유튜브 정보

  ExploreContentItem({
    required this.originId,
    required this.id,
    required this.type,
    required this.videoId,
    required this.title,
    required this.posterImgUrl,
    required this.releaseDate,
  });

  factory ExploreContentItem.fromResponse(BasicContentInfoResponse response) =>
      ExploreContentItem(
        originId: response.id,
        id: SplittedIdAndType.fromOriginId(response.id).id,
        type: SplittedIdAndType.fromOriginId(response.id).type,
        videoId: response.videoId,
        title: response.title,
        releaseDate: response.releaseDate,
        posterImgUrl: response.posterImgUrl,
      );
}
