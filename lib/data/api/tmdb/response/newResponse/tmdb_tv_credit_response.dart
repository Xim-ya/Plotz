import 'package:uppercut_fantube/utilities/index.dart';

part 'tmdb_tv_credit_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbTveCreditResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'cast')
  List<TmdbTvCastInfoResponse> cast;

  TmdbTveCreditResponse(this.id, this.cast);

  factory TmdbTveCreditResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTveCreditResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TmdbTvCastInfoResponse {
  @JsonKey(name: 'adult')
  bool adult;

  @JsonKey(name: 'gender')
  int? gender;

  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'known_for_department')
  String known_for_department;

  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'original_name')
  String original_name;

  @JsonKey(name: 'popularity')
  double popularity;

  @JsonKey(name: 'profile_path')
  String? profile_path;

  @JsonKey(name: 'cast_id')
  int cast_id;

  @JsonKey(name: 'character')
  String character;

  @JsonKey(name: 'credit_id')
  String credit_id;


  TmdbTvCastInfoResponse(
      this.adult,
      this.gender,
      this.id,
      this.known_for_department,
      this.name,
      this.original_name,
      this.popularity,
      this.profile_path,
      this.cast_id,
      this.character,
      this.credit_id,);

  factory TmdbTvCastInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbTvCastInfoResponseFromJson(json);
}