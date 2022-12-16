import 'package:youtube_explode_dart/youtube_explode_dart.dart';

/** YoutubeMeta Networking 라이브러리 통신 모듈
 * 관련 라이브러리 인스턴스를 한 번만 사용하기 위해 따로 관리함.
 * */

class YoutubeMetaData {
  YoutubeMetaData._();

  static final yt = YoutubeExplode();

}

