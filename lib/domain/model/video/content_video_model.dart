import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/data/api/content/response/video_response.dart';
import 'package:soon_sak/domain/enum/content_video_format.dart';
import 'package:soon_sak/domain/model/video/content_video.dart';

class ContentVideoModel {
  final List<ContentVideo> videos;
  final ContentVideoFormat videoFormat;
  final BehaviorSubject<String?> mainUploadDate = BehaviorSubject<String?>();
  final BehaviorSubject<int?> mainViewCount = BehaviorSubject<int?>();
  final BehaviorSubject<int?> mainLikesCount = BehaviorSubject<int?>();
  bool youtubeInfoLoaded = false;

  ContentVideoModel({required this.videos, required this.videoFormat});

  factory ContentVideoModel.fromMovieResponse(
      List<VideoResponse> response, BuildContext context) {
    final model = ContentVideoModel(
      videos: response.map((e) {
        final result = ContentVideo.fromTvResponse(e);
        return result;
      }).toList(),
      videoFormat: response.length > 1
          ? ContentVideoFormat.multipleMovie
          : ContentVideoFormat.singleMovie,
    );

    Future.wait(model.videos.map((video) => video.updateVideoDetails(context)))
        .then((_) {
      // 업로드일
      model.mainUploadDate
          .add(model.videos[0].youtubeInfo.valueOrNull?.uploadDate);

      // 좋아요 수
      int totalLikesCount = 0;
      for (final video in model.videos) {
        totalLikesCount += video.youtubeInfo.valueOrNull?.likeCount ?? 0;
      }
      model.mainLikesCount.add(totalLikesCount);

      // 조회수
      int totalViewCount = 0;
      for (final video in model.videos) {
        totalViewCount += video.youtubeInfo.valueOrNull?.viewCount ?? 0;
      }
      model.mainViewCount.add(totalViewCount);
      model.youtubeInfoLoaded = true;
    });

    return model;
  }

  factory ContentVideoModel.fromTvResponse(
      List<VideoResponse> response, BuildContext context) {
    final model = ContentVideoModel(
      videos: response.map((e) {
        final result = ContentVideo.fromTvResponse(e);
        return result;
      }).toList(),
      videoFormat: response.length > 1
          ? ContentVideoFormat.multipleTv
          : ContentVideoFormat.singleTv,
    );

    Future.wait(model.videos.map((video) => video.updateVideoDetails(context)))
        .then((_) {
      // 업로드일
      model.mainUploadDate
          .add(model.videos[0].youtubeInfo.valueOrNull?.uploadDate);

      // 좋아요 수
      int totalLikesCount = 0;
      for (final video in model.videos) {
        totalLikesCount += video.youtubeInfo.valueOrNull?.likeCount ?? 0;
      }
      model.mainLikesCount.add(totalLikesCount);

      // 조회수
      int totalViewCount = 0;
      for (final video in model.videos) {
        totalViewCount += video.youtubeInfo.valueOrNull?.viewCount ?? 0;
      }
      model.mainViewCount.add(totalViewCount);

      model.youtubeInfoLoaded = true;
    });

    return model;
  }

// factory ContentVideoModel.fromTvResponse(
//     List<VideoResponse> response, BuildContext context) {
//   final model = ContentVideoModel(
//     videos: response.map((e) {
//       final result = ContentVideo.fromTvResponse(e);
//       return result;
//     }).toList(),
//     videoFormat: response.length > 1
//         ? ContentVideoFormat.multipleTv
//         : ContentVideoFormat.singleTv,
//   );
//
//   model.videos.forEach((video) async {
//     await video.updateVideoDetails(context).whenComplete(() {
//       // 업로드일
//       model.mainUploadDate
//           .add(model.videos[0].youtubeInfo.valueOrNull?.uploadDate);
//
//       // 좋아요 수
//       int totalLikesCount = 0;
//       for (ContentVideo video in model.videos) {
//         totalLikesCount += video.youtubeInfo.valueOrNull?.likeCount ?? 0;
//       }
//       model.mainLikesCount.add(totalLikesCount);
//
//       // 조회수
//       int totalViewCount = 0;
//       for (ContentVideo video in model.videos) {
//         totalViewCount += video.youtubeInfo.valueOrNull?.viewCount ?? 0;
//       }
//       model.mainViewCount.add(totalViewCount);
//     });
//   });
//
//   return model;
// }
}
