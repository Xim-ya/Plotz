part of '../content_detail_view_model.dart';

/** Crated By Ximya - 2022.12.10
 * 컨텐츠 상세 페이지 > 정보 탭뷰 영역 컨트롤러 리소스
 * */

extension ContentDetailInfoTabViewModel on ContentDetailViewModel {
  // 컨텐츠 이미지 리스트
  List<String>? get contentImgList => contentImgUrlList;

  // 컨텐츠 이미지 존재 여부 (일부 컨텐츠에서 컨텐츠 이미지가 존재 하지 않음)
  bool? get contentImgExist {
    return contentImgUrlList?.isNotEmpty ?? true ? true : false;
  }

  // // 총 조회수
  // String? get totalViewCount => Formatter.formatNumberWithUnit(
  //       videoInfo?.mainViewCount,
  //       isViewCount: false,
  //     );
  //
  // // 좋아요 수
  // String? get likesCount {
  //   return Formatter.formatNumberWithUnit(videoInfo?.mainLikesCount);
  // }

  // 유튜브 컨텐츠 업로드 일자
  String? get youtubeUploadDate =>
      Formatter.getDateDifferenceFromNow(videoInfo?.mainUploadDate.valueOrNull);

  // 채널 설명
  String? get channelDescription => channelInfo?.description;

  // 채널 구독자 수
  int? get subscriberCount =>
      _passedArgument.subscribersCount ?? channelInfo?.subscribersCount;

  // 채널 이미지 url
  String? get channelImgUrl =>
      _passedArgument.channelLogoImgUrl ?? channelInfo?.logoImgUrl;

  // 채널 명
  String? get channelName => _passedArgument.channelName ?? channelInfo?.name;

  /// 방영일
  /// 컨텐츠 타입이 영화일 경우 방영상태 대신 방영일을 보여줌
  String? get contentReleaseDate => _contentDescriptionInfo?.releaseDate;

  // 방영상태
  String? get contentAirStatus => _contentDescriptionInfo?.airStatus;

  // 출연진 정보 개수
  int? get creditCount => contentCreditList?.length;

  // 큐레이터 정보
  UserModel? get curator => _curator;

  // 출연진 섹션 > [CarouselSlider] 개수
  int? get sliderCount {
    if (creditCount! <= 3) {
      return 1;
    } else if (creditCount == null) {
      return null;
    } else if (creditCount! % 3 == 0) {
      return int.parse((creditCount! / 3).toStringAsFixed(0));
    } else {
      return (creditCount! / 3).floor() + 1;
    }
  }

  // 출연진 정보 존재 여부 (다큐멘터리의 경우 데이터가 존재 하지 않음)
  bool? get isCreditNotEmpty {
    return contentCreditList?.isNotEmpty ?? true ? true : false;
  }

  // 출연진 섹션 > CarouselSlider > [ListView] 개수
  int? creditLengthOnSlider(int index) {
    if (creditCount == null) {
      return null;
    }
    // 첫 번째 슬라이더가 아닐 때
    if (index != 0) {
      if (creditCount! - (3 * index) <= 3) {
        return creditCount! - (3 * index);
      } else {
        return 3;
      }
    }

    // 첫 번째 슬라이더 일 때
    else {
      // 총 개수가 3개 이해 일 때
      if (creditCount! <= 3) {
        return creditCount;
      } else {
        return 3;
      }
    }
  }

  // 크레딧 리스트 인덱스
  int creditIndex({required int parentIndex, required int childIndex}) {
    return 3 * parentIndex + childIndex;
  }
}
