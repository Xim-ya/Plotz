import 'package:soon_sak/data/api/tmdb/response/newResponse/searched_content_response.dart';
import 'package:soon_sak/domain/model/content/search/searched_content.m.dart';

class SearchedContentResult {
  final int page;
  final List<SearchedContentNew> contents;

  SearchedContentResult({required this.page, required this.contents});

  factory SearchedContentResult.fromResponse(SearchedContentResponse response) {
    return SearchedContentResult(
      page: response.page,
      contents: response.results
          .map((e) => SearchedContentNew.fromResponse(e))
          .toList(),
    );
  }
}
