

import 'package:uppercut_fantube/data/network/tmdb/response/tmdb_cast_info_item_response.dart';
import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_movie_credit_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieCreditResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'cast')
  List<TmdbCastInfoItemResponse> cast;

  TmdbMovieCreditResponse(this.id, this.cast);

  factory TmdbMovieCreditResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbMovieCreditResponseFromJson(json);
}
