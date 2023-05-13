import 'package:soon_sak/utilities/index.dart';

part 'tmdb_content_credit_response.g.dart';

@JsonSerializable(createToJson: false)
class TmdbContentCreditResponse {
  @JsonKey(name: 'id')
  int id;

  @JsonKey(name: 'cast')
  List<TmdbCastInfoItemResponse> cast;

  TmdbContentCreditResponse(this.id, this.cast);

  factory TmdbContentCreditResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbContentCreditResponseFromJson(json);
}

@JsonSerializable(createToJson: false)
class TmdbCastInfoItemResponse {
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
  int? cast_id;

  @JsonKey(name: 'character')
  String character;

  @JsonKey(name: 'credit_id')
  String? credit_id;

  TmdbCastInfoItemResponse(
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

  factory TmdbCastInfoItemResponse.fromJson(Map<String, dynamic> json) =>
      _$TmdbCastInfoItemResponseFromJson(json);
}
