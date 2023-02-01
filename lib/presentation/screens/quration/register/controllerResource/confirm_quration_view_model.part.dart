part of '../register_view_model.dart';

extension ConfirmQurationViewModel on RegisterViewModel {
  String? get posterImgUrl => qurationContent!.detail?.posterImgUrl;

  String? get contentTitle => qurationContent!.detail?.title;

  String? get releaseDate => qurationContent!.detail?.releaseDate;

  String? get channelName => qurationContent!.youtubeVideo?.channelName;

  String? get channelImgUrl => qurationContent!.youtubeVideo?.channelImg;

  int? get subscriberCount => qurationContent!.youtubeVideo?.subscriberCount!;

  /// 반응형 포스터 이미지 horizon 패딩 값
  /// 375px(width) 기준 39px
  double get responsiveHInset => SizeConfig.to.screenWidth * 0.08;
}
