import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';
import 'package:rxdart/rxdart.dart';

class OldContentVideoItem {
  final int episodeNum;
  final String videoId;
  final BehaviorSubject<YoutubeVideoContentInfo?> _detailInfoSubject;
  final BehaviorSubject<SeasonInfo?> _tvSeasonInfoSubject;

  Stream<YoutubeVideoContentInfo?> get detailInfoStream =>
      _detailInfoSubject.stream;

  Stream<SeasonInfo?> get tvSeasonInfoStream => _tvSeasonInfoSubject.stream;

  YoutubeVideoContentInfo? get detailInfo => _detailInfoSubject.valueOrNull;

  SeasonInfo? get tvSeasonInfo => _tvSeasonInfoSubject.valueOrNull;

  OldContentVideoItem({
    required this.episodeNum,
    required this.videoId,
  })  : _detailInfoSubject = BehaviorSubject<YoutubeVideoContentInfo?>(),
        _tvSeasonInfoSubject = BehaviorSubject<SeasonInfo?>();

  Future<void> updateVideoDetails(BuildContext context) async {
    String selectedVideoId = videoId;
    if (videoId.contains('&')) {
      selectedVideoId = videoId.substring(0, videoId.indexOf('&'));
    }

    final responseRes = await locator<YoutubeRepository>()
        .loadYoutubeVideoContentInfo(selectedVideoId);

    responseRes.fold(
      onSuccess: (data) {
        _detailInfoSubject.add(data);
        _detailInfoSubject.close();
      },
      onFailure: (e) {
        if (e is VideoUnavailableException) {
          AlertWidget.newToast(message: '유튜버가 삭제한 영상으로 불러올 수 없습니다', context);
        } else {
          AlertWidget.newToast(message: '유튜브 영상을 호출하는데 실패했어요.', context);
        }
        log(e.toString());
      },
    );
  }

  Future<void> mappingTvSeasonInfo(
      {required List<SeasonInfo> seasonInfoList}) async {
    for (var ele in seasonInfoList) {
      if (ele.seasonNum == episodeNum) {
        _tvSeasonInfoSubject.add(ele);
        unawaited(_tvSeasonInfoSubject.close());
      }
    }
  }

  factory OldContentVideoItem.fromResponse(OldVideoResponse response) {
    return OldContentVideoItem(
      episodeNum: response.order,
      videoId: response.videoId,
    );
  }

  void dispose() {
    _detailInfoSubject.close();
    _tvSeasonInfoSubject.close();
  }
}
