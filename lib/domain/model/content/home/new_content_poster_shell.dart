import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/staticContent/response/new_category_content_item_response.dart';
import 'package:soon_sak/utilities/index.dart';

class NewContentPosterShell {
  final String originId;
  late final String? title;
  final int contentId;
  final ContentType contentType;
  final String posterImgUrl;
  late final String? videoTitle;

  NewContentPosterShell({
    required this.title,
    required this.videoTitle,
    required this.originId,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
  });

  // TopPositioned Category
  factory NewContentPosterShell.fromTopPositionedCategory(
          NewCategoryContentItemResponse response) =>
      NewContentPosterShell(
        originId: response.id,
        title: response.title,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: null,
      );

  // Channel Content
  factory NewContentPosterShell.fromChannelContents(
          ChannelContentItemResponse response) =>
      NewContentPosterShell(
        originId: response.id,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: response.videoTitle,
        title: null,
      );

  // Conttent Detail > Related Contents
  factory NewContentPosterShell.fromRelatedContents(
          ChannelContentItemResponse response) =>
      NewContentPosterShell(
        originId: response.id,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: response.videoTitle,
        title: response.title,
      );
}
