import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class BannerModel {
  BannerModel({required this.key, required this.contentList});

  String key;
  List<BannerItem> contentList;

  // From Response
  factory BannerModel.fromResponse(BannerResponse response) {
    return BannerModel(
      key: response.key,
      contentList: response.items.map(BannerItem.fromResponse).toList(),
    );
  }
}

class BannerItem {
  final String originId;
  final int id;
  final MediaType type;
  final String title;
  final String description;
  final String imgUrl;
  final String genre;

  BannerItem({
    required this.originId,
    required this.genre,
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.imgUrl,
  });

  factory BannerItem.fromResponse(BannerItemResponse response) => BannerItem(
        originId: response.id,
        id: SplittedIdAndType.fromOriginId(response.id).id,
        type: SplittedIdAndType.fromOriginId(response.id).type,
        title: response.title,
        genre:
            Formatter.formatGenreListToSingleStr2(response.genres) ?? '장르 없음',
        description: response.description,
        imgUrl: response.imgUrl,
      );
}
