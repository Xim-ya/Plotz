import 'package:uppercut_fantube/domain/enum/content_type_enum.dart';
import 'package:uppercut_fantube/domain/enum/ott_type_enum.dart';
import 'package:uppercut_fantube/domain/model/content/youtube_content.dart';

/** Created By Ximya - 2022.11.16
 * 컨텐츠 상세페이지에서 사용되는 모델 [헤더 & 컨텐츠 탭]
 * 컨텐츠 상세페이지에 필요한 데이터를 분할하기 위해 '컨텐츠' '정보' '헤더'에 필요한 데이터를 구분함.
 * */

class ContentMainInfo {
  // 헤더 영역 및 공통 영역
  final String id;
  final String title; // 컨텐츠 제목
  final List<OttType> ottTypeList; // ott 리스트
  final double rate; // 평점
  final List<String> genreList; // 장르 타입 리스트
  final String releaseDate; // 컨텐츠 출시일
  final String contentDescription; // 컨텐츠 설명
  final ContentSeasonType contentEpicType; // 시리즈물 or 단일 컨텐츠



  // 컨텐츠 탭
  final List<YoutubeContent>  youtubeContents;

  ContentMainInfo( {
    required this.id,
    required this.title,
    required this.ottTypeList,
    required this.rate,
    required this.genreList,
    required this.releaseDate,
    required this.contentEpicType,
    required this.contentDescription,
    required this.youtubeContents,
  });
}
