part of '../register_view_model.dart';

extension ConfirmQurationViewModel on RegisterViewModel {
  String? get posterImgUrl => qurationContent.value?.detail?.posterImgUrl;

  String? get contentTitle =>  qurationContent.value?.detail?.title;

  String? get releaseDate =>  qurationContent.value?.detail?.releaseDate;

  String? get channelName =>  qurationContent.value?.youtubeVideo?.channelName;

  String? get channelImgUrl =>  qurationContent.value?.youtubeVideo?.channelImg;

  int? get subscriberCount =>  qurationContent.value?.youtubeVideo?.subscriberCount!;

  /// 반응형 포스터 이미지 horizon 패딩 값
  /// 375px(width) 기준 39px
  double get responsiveHInset => SizeConfig.to.screenWidth * 0.08;
}
