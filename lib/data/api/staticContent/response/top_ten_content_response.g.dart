// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_ten_content_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TopTenContentResponse _$TopTenContentResponseFromJson(
        Map<String, dynamic> json) {
  print("아랑1");
  print("key ${json['items'][1]['id']}");
  return TopTenContentResponse(
    key: json['key'] as String,
    items: (json['items'] as List<dynamic>)
        .map((e) =>
        TopTenContentItemResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}


TopTenContentItemResponse _$TopTenContentItemResponseFromJson(
        Map<String, dynamic> json) {
  print("아랑");
  print(json);
  print(json['imgUrl']);
  return TopTenContentItemResponse(
    id: json['id'] as String,
    imgUrl: json['imgUrl'] as String,
    title: json['title'] as String,
  );
}

