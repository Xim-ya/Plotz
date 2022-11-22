part of 'content_detail_view_model.dart';

extension ContentDetailViewModelPart on ContentDetailViewModel {
  // 이전 화면에서 전달받은 컨텐츠 썸네일 값이 있다면 해당 데이터 사용. 아니라면 networking한 데이터 사용.
  String? get contentThumbnailImgUrl => passedArgument.thumbnailUrl ?? "";

  String? get youtubeContentId => passedArgument.youtubeId ?? "";

  String? get youtubeContentTitle => passedArgument.title ?? "";

  ContentSeasonType? get seasonType =>
      _contentDescriptionInfo.value?.contentEpicType;

  /// [ContentSeasonType] 의 '싱글' '시르즈' 여부에 따라 로딩 여부를 다르게 함.
  /// header ? description 섹션에서 사용됨.
  bool get isHeaderDescriptionLoaded {
    final ContentSeasonType type =
        _contentDescriptionInfo.value?.contentEpicType ??
            ContentSeasonType.single;
    if (type == ContentSeasonType.single) {
      return _youtubeVideoContentInfo.value != null;
    } else {
      return _contentDescriptionInfo.value != null;
    }
  }

  /** [컨텐츠 탭] **/
  CommentsList? get commentList => _contentCommentList.value;

  YoutubeVideoContentInfo? get youtubeVideoContentInfo =>
      _youtubeVideoContentInfo.value;

  bool get isYoutubeVideoContentInfoLoaded =>
      _youtubeVideoContentInfo.value != null;
}
