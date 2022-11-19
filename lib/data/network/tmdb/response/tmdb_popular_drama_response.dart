import 'package:uppercut_fantube/data/network/tmdb/response/tmdb_drama_item_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_popular_drama_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbPopularDramaResponse {
  @JsonKey(name: 'page')
  int page;

  @JsonKey(name: 'results')
  List<TmdbDramaItemResponse> results;

  TmdbPopularDramaResponse(this.page, this.results);

  factory TmdbPopularDramaResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbPopularDramaResponseFromJson(json);
}
