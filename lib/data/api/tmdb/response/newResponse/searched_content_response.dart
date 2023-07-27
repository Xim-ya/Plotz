import 'package:soon_sak/utilities/index.dart';

part 'searched_content_response.g.dart';

@JsonSerializable(createToJson: false)
class SearchedContentResponse {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<SearchedContentItemResponse> results;

  SearchedContentResponse(this.page, this.results);

  factory SearchedContentResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchedContentResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchedContentItemResponse {
  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'backdrop_path')
  String? backdropPath;

  @JsonKey(name: 'id')
  int id;

  // For TV shows
  @JsonKey(name: 'name')
  String? name;

  // For movies
  @JsonKey(name: 'title')
  String? title;

  @JsonKey(name: 'original_language')
  String originalLanguage;

  // For TV shows
  @JsonKey(name: 'original_name')
  String? originalName;

  // For movies
  @JsonKey(name: 'original_title')
  String? originalTitle;

  @JsonKey(name: 'overview')
  String overview;

  @JsonKey(name: 'poster_path')
  String? posterPath;

  @JsonKey(name: 'media_type')
  String mediaType;

  @JsonKey(name: 'genre_ids')
  List<int> genreIds;

  @JsonKey(name: 'popularity')
  double popularity;

  // For TV shows
  @JsonKey(name: 'first_air_date')
  String? firstAirDate;

  // For movies
  @JsonKey(name: 'release_date')
  String? releaseDate;

  // For movies
  @JsonKey(name: 'video')
  bool? video;

  @JsonKey(name: 'vote_average')
  double voteAverage;

  @JsonKey(name: 'vote_count')
  int voteCount;

  // For TV shows
  @JsonKey(name: 'origin_country')
  List<String>? originCountry;

  SearchedContentItemResponse({
    required this.adult,
    required this.backdropPath,
    required this.id,
    this.name,
    this.title,
    required this.originalLanguage,
    this.originalName,
    this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.mediaType,
    required this.genreIds,
    required this.popularity,
    this.firstAirDate,
    this.releaseDate,
    this.video,
    required this.voteAverage,
    required this.voteCount,
    this.originCountry,
  });

  factory SearchedContentItemResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchedContentItemResponseFromJson(json);
}
