
class VideoResponse {
  final int order;
  final String videoId;

  VideoResponse({required this.order, required this.videoId});

  factory VideoResponse.fromJson(
      Map<String, dynamic> json,) {
    return VideoResponse(
      order: json['order'],
      videoId: json['videoId'],
    );
  }
}

