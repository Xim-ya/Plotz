import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/utilities/index.dart';

part 'tmdb_movie_content_list_wrapped_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbMovieContentListWrappedResponse {
  @JsonKey(name: 'page')
  int page;
  @JsonKey(name: 'results')
  List<TmdbMovieDetailResponse> results;

  TmdbMovieContentListWrappedResponse(this.page, this.results);

  factory TmdbMovieContentListWrappedResponse.fromJson(
          Map<String, dynamic> json,) =>
      _$TmdbMovieContentListWrappedResponseFromJson(json);
}
