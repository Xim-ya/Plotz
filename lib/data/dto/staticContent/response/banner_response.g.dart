// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponse _$BannerResponseFromJson(Map<String, dynamic> json) =>
    BannerResponse(
      json['id'] as String,
      (json['items'] as List<dynamic>)
          .map((e) => BannerItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

BannerItemResponse _$BannerContentResponseFromJson(
        Map<String, dynamic> json) =>
    BannerItemResponse(
      json['id'] as String,
      json['videoId'] as String,
      json['title'] as String,
      json['description'] as String,
      json['imgUrl'] as String,
      json['backdropImgUrl'] as String,
    );
