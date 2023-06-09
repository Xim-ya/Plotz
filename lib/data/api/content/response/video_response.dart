import 'package:soon_sak/utilities/index.dart';

class OldVideoResponse {
  final int order;
  final String videoId;

  OldVideoResponse({required this.order, required this.videoId});

  factory OldVideoResponse.fromJson(
    Map<String, dynamic> json,
  ) {
    return OldVideoResponse(
      order: json['order'],
      videoId: json['videoId'],
    );
  }
}

class VideoResponse {
  final int order;
  final String videoId;
  late final String? overview;
  late final String? posterImageUrl;

  VideoResponse(
      {required this.order,
      required this.videoId,
      overViewRes,
      posterImgUrlRes})
      : overview = overViewRes,
        posterImageUrl = posterImgUrlRes;

  factory VideoResponse.fromMovieJson(
    Map<String, dynamic> json,
  ) {
    return VideoResponse(
        order: json['order'],
        videoId: json['videoId'],
        posterImgUrlRes: json['posterImgUrl']);
  }

  factory VideoResponse.fromTvMovieJson(
    Map<String, dynamic> json,
  ) {
    return VideoResponse(
        order: json['order'],
        videoId: json['videoId'],
        overViewRes: json['overview'],
        posterImgUrlRes: json['posterImgUrl']);
  }
}
