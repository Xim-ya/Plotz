import 'package:uppercut_fantube/utilities/index.dart';

class BannerModel extends BaseSingleDataModel {
  BannerModel({this.key, this.contentList});

  String? key;
  List<BannerItem>? contentList;

  @override
  bool get isLoaded => contentList.hasData;

  // 데이터 호출
  @override
  Future<void> fetchData() async {
    final response = await StaticContentRepository.to.loadBannerContentList();
    response.fold(
        onSuccess: (data) {
          key = data.key;
          contentList = data.contentList;
        },
        onFailure: (e) {});
  }

  factory BannerModel.fromResponse(BannerResponse response) {
    return BannerModel(
        key: response.key,
        contentList: response.items.map(BannerItem.fromResponse).toList());
  }

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    List<dynamic> jsonItemList = json['items'];

    return BannerModel(
        key: json['key'],
        contentList: jsonItemList.map((e) => BannerItem.fromJson(e)).toList());
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
