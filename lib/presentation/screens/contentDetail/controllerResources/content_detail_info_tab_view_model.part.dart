part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 * 컨텐츠 상세 페이지 > 정보 탭뷰 영역 컨트롤러 리소스
 * */

extension ContentDetailInfoTabViewModel on ContentDetailViewModel {
  // 컨텐츠 이미지 리스트
  List<String>? get contentImgUrlList => _contentImgUrlList.value;

  // 총 조회수
  String? get totalViewCount => Formatter.formatViewAndLikeCount(
        _youtubeVideoContentInfo.value?.viewCount,
        isViewCount: false,
      );

  // 채널 설명
  String? get channelDescription => _youtubeChannelInfo.value?.description;

  // 채널 구독자 수
  String? get subscriberCount => Formatter.formatViewAndLikeCount(
      _youtubeChannelInfo.value?.subscriberCount);

  // 채널 영상 개수
  String? get totalVideoCount => Formatter.formatViewAndLikeCount(_youtubeChannelInfo.value?.totalViewCount, isViewCount: true);

  // 채널 이미지 url
  String? get channelImgUrl => _youtubeChannelInfo.value?.channelImgUrl;

  // 채널 명
  String? get channelName => _youtubeChannelInfo.value?.name;

  /// 방영일
  /// 컨텐츠 타입이 영화일 경우 방영상태 대신 방영일을 보여줌
  String? get contentReleaseDate => _contentDescriptionInfo.value?.releaseDate;

  //방영상태
  String? get contentAirStatus => _contentDescriptionInfo.value?.airStatus;

  // 출연진 정보
  List<ContentCreditInfo>? get contentCreditList => _contentCreditList.value;

  // 출연진 정보 개수
  int? get creditCount => _contentCreditList.value?.length;

  // 출연진 섹션 > [CarouselSlider] 개수
  int? get sliderCount {
    if (creditCount! < 3) {
      return 1;
    } else if (creditCount == null) {
      return null;
    } else if (creditCount! % 3 == 0) {
      return creditCount! / 3 as int;
    } else {
      return (creditCount! / 3).floor() + 1;
    }
  }

  // 출연진 섹션 > CarouselSlider > [ListView] 개수
  int? creditLengthOnSlider(int index) {
    // 마지막 일 때
    if (creditCount == null) {
      return null;
    } else if (index + 1 == sliderCount) {
      return (creditCount! % 3).floor();
    }
    // 첫번째 이지만 3개 이하일 떄
    else if (index == 0 && creditCount! < 3) {
      return creditCount!;
    }
    // 첫번 째이고 3개 이상 일 때
    else if (index == 0 && creditCount! >= 3) {
      return 3;
    } else {
      return 3;
    }
  }

  // 크레딧 리스트 인덱스
  int creditIndex({required int parentIndex, required int childIndex}) {
    return 3 * parentIndex + childIndex;
  }
}
