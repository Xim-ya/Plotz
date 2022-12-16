import 'package:uppercut_fantube/utilities/index.dart';

// Credit 데이터 모델 (출연진 및 제작자)

class ContentCreditInfo {
  final String? profilePath; // 프로필 이미지
  final String name; // 이름
  final String role; // 역할

  ContentCreditInfo(
      {required this.profilePath, required this.name, required this.role});

  factory ContentCreditInfo.fromResponse(TmdbTvCastInfoResponse response) =>
      ContentCreditInfo(
          profilePath: response.profile_path,
          name: response.name,
          role: _departmentTranslateMapping(response.known_for_department));
}

/// 특정 TMDB API에서 한국어를 지원안하는 경우가 있기 때문에
/// 따로 매핑 로직을 만듦
String _departmentTranslateMapping(String departmentOnEng) {
  switch (departmentOnEng) {
    case 'Acting':
      return '배우';
    case 'Actors':
      return '배우';
    case 'Writing':
      return '각본';
    case 'Art':
      return '미술';
    case 'Camera':
      return '카메라';
    case 'Costume & Make-Up':
      return '의상 & 분장';
    case 'Creator':
      return '창작자';
    case 'Crew':
      return '제작진';
    case 'Directing':
      return '연출';
    case 'Editing':
      return '편집';
    case 'Lighting':
      return '조명';

    case 'Production':
      return '제작';

    case 'Sound':
      return '음향';

    case 'Visual Effects':
      return '시각 효과';

    default:
      return '정보 없음';
  }
}
