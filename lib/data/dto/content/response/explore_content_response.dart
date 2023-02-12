import 'package:uppercut_fantube/utilities/index.dart';

@JsonSerializable(createToJson: false)
class ExploreContentResponse {
  final String id;
  final String title;
  final String videoId;
  final String releaseDate;
  final String posterImgUrl;

  ExploreContentResponse({
    required this.id,
    required this.title,
    required this.videoId,
    required this.releaseDate,
    required this.posterImgUrl,
  });

  factory ExploreContentResponse.fromJson(Map<String, dynamic> json) {
    return ExploreContentResponse(
      id: json['id'],
      title: json['title'],
      videoId: json['videoId'],
      releaseDate: json['releaseDate'],
      posterImgUrl: json['posterImgUrl'],
    );
  }
}
