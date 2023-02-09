import 'package:uppercut_fantube/data/dto/staticContent/response/banner_response.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class BannerModel {
  String? id;
  List<BannerItem>? contentList;

  bool get isLoaded => contentList.hasData;

  BannerModel({this.id, this.contentList});



  // 데이터 호출
  Future<void> fetchBannerContentList() async {
    final response = await StaticContentRepository.to.loadBannerContentList();
    response.fold(
        onSuccess: (data) {
          id = data.id;
          contentList = data.contentList;
        },
        onFailure: (e) {});
  }

  factory BannerModel.fromResponse(BannerResponse response) {
    return BannerModel(
        id: response.id,
        contentList: response.items.map(BannerItem.fromResponse).toList());
  }
}

class BannerItem {
  final int id;
  final String videoId;
  final ContentType type;
  final String title;
  final String description;
  final String imgUrl;
  final String backdropImgUrl;

  BannerItem({
    required this.id,
    required this.videoId,
    required this.type,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.backdropImgUrl,
  });

  factory BannerItem.fromResponse(BannerItemResponse response) => BannerItem(
        id: SplittedIdAndType.fromOriginId(response.id).id,
        videoId: response.videoId,
        type: SplittedIdAndType.fromOriginId(response.id).type,
        title: response.title,
        description: response.description,
        imgUrl: response.imgUrl,
        backdropImgUrl: response.backdropImgUrl,
      );

  // Mock Json 데이터 (임시)
  factory BannerItem.fromJson(Map<String, dynamic> json) {
    return BannerItem(
        id: SplittedIdAndType.fromOriginId(json['id']).id,
        videoId: json['videoId'],
        type: SplittedIdAndType.fromOriginId(json['id']).type,
        title: json['title'],
        description: json['description'],
        imgUrl: json['imgUrl'],
        backdropImgUrl: json['backdropImgUrl']);
  }
}
