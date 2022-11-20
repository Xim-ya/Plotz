part of 'content_detail_view_model.dart';

extension ContentDetailViewModelPart on ContentDetailViewModel {
  // 이전 화면에서 전달받은 컨텐츠 썸네일 값이 있다면 해당 데이터 사용. 아니라면 networking한 데이터 사용.
  String? get contentThumbnailImgUrl => passedArgument.thumbnailUrl ?? "";

  String? get youtubeContentId => passedArgument.youtubeId ?? "";

  /** [컨텐츠 탭] **/
  CommentsList? get commentList => _contentCommentList.value;
}
