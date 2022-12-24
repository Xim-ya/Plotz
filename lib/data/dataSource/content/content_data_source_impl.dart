import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:uppercut_fantube/domain/model/content/content_episode_info_item.dart';
import 'package:uppercut_fantube/domain/model/content/simple_content_info.dart';
import 'package:uppercut_fantube/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin
    implements ContentDataSource {
  // 상단 노출 컨텐츠 리스트
  @override
  Future<List<PosterExposureContent>> loadTopExposedContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText = await rootBundle
        .loadString('assets/mocks/home_top_section_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['items'];
    return aim.map((e) => PosterExposureContent.fromJson(e)).toList();

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

  // Top10 컨텐츠 리스트 호출
  @override
  Future<List<PosterExposureContent>> loadTopTenContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText =
        await rootBundle.loadString('assets/mocks/top_ten_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = data['items'];
    return aim.map((e) => PosterExposureContent.fromJson(e)).toList();
  }

  @override
  Future<List<CategoryBaseContentList>> loadContentWithCategory() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText = await rootBundle
        .loadString('assets/mocks/category_base_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = await data['items'];
    return aim.map((e) => CategoryBaseContentList.fromJson(e)).toList();
  }

  @override
  Future<List<SimpleContentInfo>> loadTotalTvContentList() async {
    // 임시 Json Mock up Data
    // top_ten_content_list.json
    var jsonText =
        await rootBundle.loadString('assets/mocks/total_tv_content_list.json');
    Map<String, dynamic> data = json.decode(jsonText);
    List<dynamic> aim = await data['items'];
    return aim.map((e) => SimpleContentInfo.fromJson(e)).toList();
  }
}
