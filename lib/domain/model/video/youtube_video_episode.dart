import 'dart:developer';

import 'package:uppercut_fantube/domain/model/content/season_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2022.12.31
 *  컨텐츠 회차와 유튜브 영상 id 값을 담고 있는 데이터 모델
 *  ex) 영화 - 파이트클럽 1부, 파이트클럽 2부
 *  ex) 드라마 - 브레이킹 베드 시즌1, 브레이킹 베드 시즌 2..
 *  [DTO]
 *  {
    "order": 1,
    "videoId": "OK2zw7dwhng"
    }
 * */

class YoutubeVideo {
  final int episodeNum; // 시즌, 회차
  final String videoId;
  late YoutubeVideoContentInfo? detailInfo;
  late SeasonInfo? tvSeasonInfo;

  YoutubeVideo(
      {required this.episodeNum, required this.videoId}); // 유튜브 비디오 아이디

  /// 유튜브 비디오 상세 정보를 호출
  /// 호출한 데이터로 lazy [detailInfo] 필드값을 업데이트
  Future<void> updateVideoDetails() async {
    String selectedVideoId = videoId;
    if (videoId.contains('&')) {
      selectedVideoId = videoId.substring(0, videoId.indexOf('&'));
      // 타임라인이 포함되어 있는 youtubeVideoId라면 타임라인 pattern을 삭제
    }
    final responseRes =
        await YoutubeRepository.to.loadYoutubeVideoContentInfo(selectedVideoId);
    responseRes.fold(onSuccess: (data) {
      detailInfo = data;
    }, onFailure: (e) {
      AlertWidget.toast('유튜브 영상을 호출하는데 실패했어요');
      log(e.toString());
    });
  }

  Future<void> mappingTvSeasonInfo(
      {required List<SeasonInfo> seasonInfoList}) async {
    for (var ele in seasonInfoList) {
      // 시즌 넘버가 일치한다면 값을 업데이트 함.
      if (ele.seasonNum == episodeNum) {
        tvSeasonInfo = ele;
      }
    }
  }

  factory YoutubeVideo.fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(episodeNum: json['order'], videoId: json['videoId']);
  }
}
