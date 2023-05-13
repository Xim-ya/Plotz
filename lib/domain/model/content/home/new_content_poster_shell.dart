import 'package:soon_sak/data/api/staticContent/response/new_category_content_item_response.dart';
import 'package:soon_sak/utilities/index.dart';

class NewContentPosterShell {
  final String originId;
  final String title;
  final int contentId;
  final ContentType contentType;
  final String posterImgUrl;

  NewContentPosterShell({
    required this.originId,
    required this.title,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
  });

  factory NewContentPosterShell.fromResponse(
          NewCategoryContentItemResponse response) =>
      NewContentPosterShell(
        originId: response.id,
        title: response.title,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
      );
}
