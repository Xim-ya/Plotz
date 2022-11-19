import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:uppercut_fantube/data/dataSource/content/content_data_source.dart';
import 'package:uppercut_fantube/domain/model/content/top_exposed_content_list.dart';
import 'package:uppercut_fantube/utilities/api_error_handler_mixin.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin
    implements ContentDataSource {
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
}
