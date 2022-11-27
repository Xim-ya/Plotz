import 'package:uppercut_fantube/data/api/tmdb/response/newResponse/tmdb_tv_credit_response.dart';

class TvContentCreditInfo {
  final String? profilePath;
  final String name;
  final String role;

  TvContentCreditInfo(
      {required this.profilePath, required this.name, required this.role});

  factory TvContentCreditInfo.fromResponse(TmdbTvCastInfoResponse response) =>
      TvContentCreditInfo(
          profilePath: response.profile_path,
          name: response.name,
          role: response.known_for_department);
}
