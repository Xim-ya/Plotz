import 'package:soon_sak/data/api/staticContent/response/new_category_content_item_response.dart';
import 'package:soon_sak/data/api/staticContent/response/top_positioned_collection_response.dart';
import 'package:soon_sak/domain/model/content/home/new_content_poster_shell.dart';

class TopPositionedCollection {
  final String key;
  final List<TopPositionedCategory> categories;

  TopPositionedCollection({required this.key, required this.categories});

  factory TopPositionedCollection.fromResponse(
          TopPositionedCollectionResponse response) =>
      TopPositionedCollection(
          key: response.key,
          categories: response.categories
              .map((e) => TopPositionedCategory.fromResponse(e))
              .toList());
}

class TopPositionedCategory {
  final String title;
  final List<NewContentPosterShell> items;

  TopPositionedCategory({required this.title, required this.items});

  factory TopPositionedCategory.fromResponse(
          TopPositionedCategoryResponse response) =>
      TopPositionedCategory(
          title: response.title,
          items: response.items
              .map((e) => NewContentPosterShell.fromTopPositionedCategory(e))
              .toList());
}
