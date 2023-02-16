part of '../register_view_model.dart';


extension ConfirmCurationViewModel on RegisterViewModel {
  String? get posterImgUrl => curationContent.value?.detail?.posterImgUrl;

  String? get contentTitle =>  curationContent.value?.detail?.title;

  String? get releaseDate =>  curationContent.value?.detail?.releaseDate;

  String? get channelName =>  curationContent.value?.youtubeVideo?.channelName;

  String? get channelImgUrl =>  curationContent.value?.youtubeVideo?.channelImg;

  int? get subscriberCount =>  curationContent.value?.youtubeVideo?.subscriberCount!;

  /// 반응형 포스터 이미지 horizon 패딩 값
  /// 375px(width) 기준 39px
  double get responsiveHInset => SizeConfig.to.screenWidth * 0.08;
}
