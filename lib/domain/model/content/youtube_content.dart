
class YoutubeContent {
  final int likes; // 좋아요 수
  final int viewCount; // 조회수
  final String releaseDate; // 비디오 컨텐츠 등록일
  final String lastUpdateDate; // 마지막으로 서베에 업데이트된 일자
  final String videoId; // 유튜브 비디오 아이디

  YoutubeContent({
    required this.likes,
    required this.viewCount,
    required this.releaseDate,
    required this.lastUpdateDate,
    required this.videoId,
  });
}
