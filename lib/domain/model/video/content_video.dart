import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:soon_sak/app/di/locator/locator.dart';
import 'package:soon_sak/data/api/content/response/video_response.dart';
import 'package:soon_sak/data/repository/youtube/youtube_repository.dart';
import 'package:soon_sak/domain/model/content/content.dart';
import 'package:soon_sak/domain/model/youtube/youtube_video_content_info.dart';
import 'package:soon_sak/presentation/common/alert/alert_widget.dart';
import 'package:soon_sak/presentation/screens/contentDetail/content_detail_view_model.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
