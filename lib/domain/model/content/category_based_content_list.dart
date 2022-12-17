import 'package:uppercut_fantube/domain/model/content/exposure_content.dart';

class CategoryBaseContentList {
  final String category; // 카테고리
  final List<PosterExposureContent>? contents; // 해당 카테고리 컨텐츠 리스트

  CategoryBaseContentList({required this.category, required this.contents});

  factory CategoryBaseContentList.fromJson(Map<String, dynamic> json) {
    final Iterable contentListRes = json['contents'];

    return CategoryBaseContentList(
        category: json['category'],
        contents: contentListRes
            .map((e) => PosterExposureContent.fromJson(e))
            .toList());
  }
}
