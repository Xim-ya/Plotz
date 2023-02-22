import 'package:soon_sak/utilities/index.dart';

mixin YoutubeMetaDataHelper   {
  final _db = YoutubeMetaData.yt;

  VideoClient get videoClient => _db.videos;

  // 비디오 객체를 불러오는 메소드
  Future<Video> getVideoRes(String videoId) async {
    final video = await _db.videos.get(videoId);
    return video;
  }
}
