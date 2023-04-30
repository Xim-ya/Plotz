import 'package:soon_sak/utilities/index.dart';

class BannerModel  {
  BannerModel({required this.key, required this.contentList});

  String key;
  List<BannerItem> contentList;

  // From Response
  factory BannerModel.fromResponse(BannerResponse response) {
    return BannerModel(
        key: response.key,
        contentList: response.items.map(BannerItem.fromResponse).toList(),);
  }
}

class BannerItem {
  final String originId;
  final int id;
  final ContentType type;
  final String title;
  final String description;
  final String imgUrl;
  final String backdropImgUrl;

  BannerItem({
    required this.originId,
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.backdropImgUrl,
  });

  factory BannerItem.fromResponse(BannerItemResponse response) => BannerItem(
    originId: response.id,
        id: SplittedIdAndType.fromOriginId(response.id).id,
        type: SplittedIdAndType.fromOriginId(response.id).type,
        title: response.title,
        description: response.description,
        imgUrl: response.imgUrl,
        backdropImgUrl: response.backdropImgUrl,
      );
}





