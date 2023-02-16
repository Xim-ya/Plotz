import 'package:soon_sak/utilities/index.dart';

part 'tmdb_tv_content_list_wrapped_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbTvContentListWrappedResponse {
  @JsonKey(name: 'page')
  int page;
  @JsonKey(name: 'results')
  List<TmdbTvDetailResponse> results;

  TmdbTvContentListWrappedResponse(this.page, this.results);

  factory TmdbTvContentListWrappedResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvContentListWrappedResponseFromJson(json);
}
