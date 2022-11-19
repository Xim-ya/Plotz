
import 'package:uppercut_fantube/data/network/tmdb/response/tmdb_movie_video_info_item_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_movie_video_info_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieVideoInfoResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'results')
  List<TmdbMovieVideoInfoItemResponse> results;

  TmdbMovieVideoInfoResponse(this.id, this.results);

  factory TmdbMovieVideoInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieVideoInfoResponseFromJson(json);
}
