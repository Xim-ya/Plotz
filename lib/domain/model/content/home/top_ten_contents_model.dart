import 'package:soon_sak/domain/model/content/home/content_poster_shell.dart';
import 'package:soon_sak/utilities/index.dart';

class TopTenContentsModel  {
  late String? key;
  late List<ContentPosterShell>? contentList;

  TopTenContentsModel({this.key, this.contentList});

  // From Response
  factory TopTenContentsModel.fromResponse(TopTenContentResponse response) =>
      TopTenContentsModel(
        key: response.key,
        contentList:
            response.items.map(ContentPosterShell.fromResponse).toList(),
      );
}
