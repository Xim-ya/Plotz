part of '../register_view_model.dart';


extension ConfirmCurationViewModel on RegisterViewModel {
  String? get posterImgUrl => curationContent?.detail?.posterImgUrl;

  String? get contentTitle =>  curationContent?.detail?.title;

  String? get releaseDate =>  curationContent?.detail?.releaseDate;

  String? get channelName =>  curationContent?.youtubeVideo?.channelName;

  String? get channelImgUrl =>  curationContent?.youtubeVideo?.channelImg;

  int? get subscriberCount =>  curationContent?.youtubeVideo?.subscriberCount!;

  /// 반응형 포스터 이미지 horizon 패딩 값
  /// 375px(width) 기준 39px
  double get responsiveHInset => SizeConfig.to.screenWidth * 0.08;
}
