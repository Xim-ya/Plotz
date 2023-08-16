// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'newly_added_content_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewlyAddedContentResponse _$NewlyAddedContentResponseFromJson(
        Map<String, dynamic> json) =>
    NewlyAddedContentResponse(
      json['key'] as String,
      (json['items'] as List<dynamic>)
          .map((e) =>
              CategoryContentItemResponse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
