import 'dart:developer';
import 'package:soon_sak/app/index.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/presentation/index.dart';
import 'package:soon_sak/utilities/index.dart';

@SingleImport()
class ContentVideo {
  final int episodeNum;
  final String videoId;
  late final String? overview;
  late final String? posterImageUrl;
  final BehaviorSubject<YoutubeVideoContentInfo?> youtubeInfo;

  ContentVideo(
      {required this.episodeNum,
      required this.videoId,
      overViewRes,
      posterImgUrlRes})
      : overview = overViewRes,
        posterImageUrl = posterImgUrlRes,
        youtubeInfo = BehaviorSubject<YoutubeVideoContentInfo?>();

  factory ContentVideo.fromMovieResponse(VideoResponse response) {
    return ContentVideo(episodeNum: response.order, videoId: response.videoId);
  }

  factory ContentVideo.fromTvResponse(VideoResponse response) => ContentVideo(
        episodeNum: response.order,
        videoId: response.videoId,
        overViewRes: response.overview,
        posterImgUrlRes: response.posterImageUrl,
      );

  Future<void> updateVideoDetails(BuildContext context) async {
    String selectedVideoId = videoId;
    if (videoId.contains('&')) {
      selectedVideoId = videoId.substring(0, videoId.indexOf('&'));
    }

    final responseRes = await locator<YoutubeRepository>()
        .loadYoutubeVideoContentInfo(selectedVideoId);

    responseRes.fold(
      onSuccess: (data) {
        youtubeInfo.add(data);
        youtubeInfo.close();
        print("유튜브 비디오 추가됨");
      },
      onFailure: (e) {
        print("유튜브 비디오 호출 실패됨");

        if (e is VideoUnavailableException) {
          AlertWidget.newToast(message: '삭제된 유튜브 영상으로 불러올 수 없습니다', context);
        } else {
          AlertWidget.newToast(message: '유튜브 영상을 호출하는데 실패했어요.', context);
        }
        log(e.toString());
      },
    );
  }
}
