import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

class TopTenContentsModel extends BaseSingleDataModel {
  late String? key;
  late List<ContentPosterShell>? contentList;

  TopTenContentsModel({this.key, this.contentList});

  @override
  Future<void> fetchData() async {
    final response = await StaticContentRepository.to.loadTopTenContent();
    response.fold(
      onSuccess: (data) {
        key = data.key;
        contentList = data.contentList;
      },
      onFailure: (e) {
        AlertWidget.newToast('Top 10 정보를 불러오는데 실패했어요');
        log(e.toString());
      },
    );
  }

  @override
  bool get isLoaded => contentList.hasData;

  // From Response
  factory TopTenContentsModel.fromResponse(TopTenContentResponse response) =>
      TopTenContentsModel(
        key: response.key,
        contentList:
            response.items.map(ContentPosterShell.fromResponse).toList(),
      );
}
