import 'package:soon_sak/utilities/index.dart';

class SearchContentModel {
  final int page;
  final List<SearchedContent> contents;

  SearchContentModel({required this.page, required this.contents});

  // Tv Response
  factory SearchContentModel.fromTvResponse(
          TmdbTvContentListWrappedResponse response,) =>
      SearchContentModel(
          page: response.page,
          contents:
              response.results.map(SearchedContent.fromTvResponse).toList(),);

  // Movie Response
  factory SearchContentModel.fromMovieResponse(
          TmdbMovieContentListWrappedResponse response,) =>
      SearchContentModel(
          page: response.page,
          contents:
              response.results.map(SearchedContent.fromMovieResponse).toList(),);
}
