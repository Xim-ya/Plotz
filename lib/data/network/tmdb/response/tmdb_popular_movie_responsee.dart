import 'package:uppercut_fantube/data/network/tmdb/response/tmdb_movie_item_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_popular_movie_responsee.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieResponse {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<TmdbMovieItemResponse> results;

  TmdbMovieResponse(this.page, this.results);

  factory TmdbMovieResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieResponseFromJson(json);
}
