import 'dart:developer';

import 'package:uppercut_fantube/data/dto/staticContent/response/top_ten_content_response.dart';
import 'package:uppercut_fantube/data/repository/staticContent/static_content_repository.dart';
import 'package:uppercut_fantube/domain/base/base_single_data_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class TopTenContentsModel extends BaseSingleDataModel {
  late String? id;
  late List<ContentPosterShell>? contentList;

  TopTenContentsModel({this.id, this.contentList});

  @override
  Future<void> fetchData() async {
    final response = await StaticContentRepository.to.loadTopTenContent();
    response.fold(
      onSuccess: (data) {
        id = data.id;
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

  factory TopTenContentsModel.fromResponse(TopTenContentResponse response) =>
      TopTenContentsModel(
        id: response.id,
        contentList:
            response.items.map(ContentPosterShell.fromResponse).toList(),
      );
}
