import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.12.31
 *  컨텐츠 회차와 유튜브 영상 id 값을 담고 있는 데이터 모델
 *  ex) 영화 - 파이트클럽 1부, 파이트클럽 2부
 *  ex) 드라마 - 브레이킹 베드 시즌1, 브레이킹 베드 시즌 2..
 * */

class ContentVideoItem {
  final int episodeNum; // 시즌, 회차
  final String videoId; // 유튜브 비디오 아이디
   YoutubeVideoContentInfo? _detailInfo; // 유튜브 상세 정보 (late)
   SeasonInfo? _tvSeasonInfo; // Tv 컨텐츠일 경우, 시즌 정보 (late)

  // Getters
  YoutubeVideoContentInfo? get detailInfo => _detailInfo;

  SeasonInfo? get tvSeasonInfo => _tvSeasonInfo;

  ContentVideoItem({
    required this.episodeNum,
    required this.videoId,
  });

  /// 유튜브 비디오 상세 정보를 호출
  /// 호출한 데이터로 [detailInfo] Rx 필드값을 업데이트
  Future<void> updateVideoDetails() async {
    String selectedVideoId = videoId;
    if (videoId.contains('&')) {
      selectedVideoId = videoId.substring(0, videoId.indexOf('&'));
      // 타임라인이 포함되어 있는 youtubeVideoId라면 타임라인 pattern을 삭제
    }
    final responseRes = await locator<YoutubeRepository>()
        .loadYoutubeVideoContentInfo(selectedVideoId);
    responseRes.fold(
      onSuccess: (data) {
        _detailInfo = data;
      },
      onFailure: (e) {
        AlertWidget.toast('유튜브 영상을 호출하는데 실패했어요');
        log(e.toString());
      },
    );
  }

  // Tv 컨텐츠 시즌 리스트 정보를 호출
  // 호출한 정보를 조건으로 [_tvSeasonInfo] 값에 매핑시켜 관리.
  Future<void> mappingTvSeasonInfo({
    required List<SeasonInfo> seasonInfoList,
  }) async {
    for (var ele in seasonInfoList) {
      // 시즌 넘버가 일치한다면 값을 업데이트 함.
      if (ele.seasonNum == episodeNum) {
        _tvSeasonInfo = ele;
      }
    }
  }

  factory ContentVideoItem.fromJson(Map<String, dynamic> json) {
    return ContentVideoItem(
      episodeNum: json['order'],
      videoId: json['videoId'],
    );
  }

  factory ContentVideoItem.fromResponse(VideoResponse response) {
    return ContentVideoItem(
      episodeNum: response.order,
      videoId: response.videoId,
    );
  }
}
