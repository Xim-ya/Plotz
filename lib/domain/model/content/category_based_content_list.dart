import 'package:soon_sak/domain/model/content/exposure_content.dart';

class CategoryBaseContentList {
  final String category; // 카테고리
  final List<PosterExposureContent>? contents; // 해당 카테고리 컨텐츠 리스트

  CategoryBaseContentList({required this.category, required this.contents});

  factory CategoryBaseContentList.fromJson(Map<String, dynamic> json) {
    final List<dynamic> contentListRes = json['contents'] as List<dynamic>;

    return CategoryBaseContentList(
      category: json['category'],
      contents: contentListRes
          .map<PosterExposureContent>((content) => PosterExposureContent.fromJson(content))
          .toList(),
    );
  }
}
