import 'package:uppercut_fantube/utilities/index.dart';

class BannerContent {
  final int id;
  final String videoId;
  final ContentType type;
  final String title;
  final String description;
  final String imgUrl;
  final String backdropImgUrl;

  BannerContent({
    required this.id,
    required this.videoId,
    required this.type,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.backdropImgUrl,
  });

  factory BannerContent.fromJson(Map<String, dynamic> json) {
    return BannerContent(
        id: SplittedIdAndType.fromOriginId(json['id']).id,
        videoId: json['videoId'],
        type: SplittedIdAndType.fromOriginId(json['id']).type,
        title: json['title'],
        description: json['description'],
        imgUrl: json['imgUrl'],
        backdropImgUrl: json['backdropImgUrl']);
  }
}
