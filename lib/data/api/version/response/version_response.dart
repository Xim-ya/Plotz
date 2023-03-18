import 'package:json_annotation/json_annotation.dart';

part 'version_response.g.dart';

/** Created By Ximya - 2023.03.01
 *  버전 정보 Response 객체
 *  versionCode : 앱의 버전을 식별하는 값 / 1.3.0 (주부수)
 *  versionName : 앱의 상세화된 정보  / 1.0.5-beta
 *  systemAvailable : 시스템 작동 여부. 필요 시 점검 문구를 노출할 때 사용됨 / Y , N (문자열)
 *
 *  Edited By Ximya - 2023.03.16
 *  systemAvailable : 배포중일 때 -> R
 * */

@JsonSerializable(createToJson: false)
class VersionResponse {
  @JsonKey(name: 'versionCode')
  final String versionCode;

  @JsonKey(name: 'versionName')
  final String versionName;

  @JsonKey(name: 'systemAvailable')
  final String systemAvailable;

  VersionResponse({
    required this.versionCode,
    required this.versionName,
    required this.systemAvailable,
  });

  factory VersionResponse.fromJson(Map<String, dynamic> json) =>
      _$VersionResponseFromJson(json);
}
