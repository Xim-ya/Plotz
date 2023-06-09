import 'package:soon_sak/data/api/channel/response/channel_content_item_response.dart';
import 'package:soon_sak/data/api/staticContent/response/category_content_item_response.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentPosterShell {
  final String originId;
  late final String? title;
  final int contentId;
  final ContentType contentType;
  final String posterImgUrl;
  late final String? videoTitle;

  ContentPosterShell({
    required this.title,
    required this.videoTitle,
    required this.originId,
    required this.contentId,
    required this.contentType,
    required this.posterImgUrl,
  });

  // TopPositioned Category
  factory ContentPosterShell.fromTopPositionedCategory(
          CategoryContentItemResponse response) =>
      ContentPosterShell(
        originId: response.id,
        title: response.title,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: null,
      );

// TopTen
  factory ContentPosterShell.fromResponse(TopTenContentItemResponse response) =>
      ContentPosterShell(
        originId: response.id,
        title: response.title,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.imgUrl,
        videoTitle: null,
      );

  // Channel Content
  factory ContentPosterShell.fromChannelContents(
          ChannelContentItemResponse response) =>
      ContentPosterShell(
        originId: response.id,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: response.videoTitle,
        title: null,
      );

  // Conttent Detail > Related Contents
  factory ContentPosterShell.fromRelatedContents(
          ChannelContentItemResponse response) =>
      ContentPosterShell(
        originId: response.id,
        contentId: SplittedIdAndType.fromOriginId(response.id).id,
        contentType: SplittedIdAndType.fromOriginId(response.id).type,
        posterImgUrl: response.posterImgUrl,
        videoTitle: response.videoTitle,
        title: response.title,
      );
}
