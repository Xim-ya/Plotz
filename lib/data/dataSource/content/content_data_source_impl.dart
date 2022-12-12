import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uppercut_fantube/domain/model/content/content_episode_info_item.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin
    implements ContentDataSource {
  // 상단 노출 컨텐츠 리스트
  @override
  Future<List<TopExposedContent>> loadTopExposedContentList() async {
    // 임시 Json Mock up Data
    var jsonText = await rootBundle
        .loadString('assets/mocks/home_top_section_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['items'];
    return aim.map((e) => TopExposedContent.fromJson(e)).toList();

    // final responseValue = ChannelImagesDescriptionsReswponse.fromJson(data);
    // return responseValue;
  }

  // 컨텐츠 에피소드 리스트 정보
  @override
  Future<List<ContentEpisodeInfoItem>> loadContentEpisodeItemList() async {
    // 임시 Json Mock up Data
    var jsonText = await rootBundle
        .loadString('assets/mocks/content_season_info_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['episode'];
    return aim.map((e) => ContentEpisodeInfoItem.fromJson(e)).toList();
  }
}
