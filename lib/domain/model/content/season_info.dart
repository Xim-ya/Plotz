import 'package:soon_sak/data/index.dart';

class SeasonInfo {
  final String? airDate; // 방영일
  final int seasonNum; // 시즌
  final String name; // 시즌 이름
  final String description; // 설명(overView)
  final String? posterPathUrl; // 포스터 이미지 url

  SeasonInfo(
      {required this.airDate,
      required this.seasonNum,
      required this.name,
      required this.description,
      required this.posterPathUrl,});

  factory SeasonInfo.fromResponse(SeasonResponse response) => SeasonInfo(
        airDate: response.air_date,
        seasonNum: response.season_number,
        name: response.name,
        description: response.overview,
        posterPathUrl: response.poster_path,
      );
}
