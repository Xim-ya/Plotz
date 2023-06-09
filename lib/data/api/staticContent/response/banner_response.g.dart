// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      json['key'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => BannerItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BannerItemResponse _$BannerItemResponseFromJson(Map<String, dynamic> json) =>
    BannerItemResponse(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      imgUrl: json['imgUrl'] as String,
      genres:
          (json['genres'] as List<dynamic>).map((e) => e as String).toList(),
    );
