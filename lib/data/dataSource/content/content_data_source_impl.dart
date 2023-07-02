import 'package:soon_sak/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin, FirebaseIsolateHelper
    implements ContentDataSource {
  ContentDataSourceImpl(this._api);

  final ContentApi _api;

  @override
  Future<List<String>> loadTotalContentIdList() =>
      loadWithFirebaseIsolate(_api.loadTotalContentIdList);

  @override
  Future<List<OldVideoResponse>> oldLoadVideoInfo(String id) =>
      loadWithFirebaseIsolate(
        () => loadResponseOrThrow(() => _api.oldLoadVideoInfo(id)),
      );

  @override
  Future<List<VideoResponse>> loadVideoInfo(
      {required String contentId, required ContentType contentType}) async {
    return loadResponseOrThrow(() =>
        _api.loadVideoInfo(contentId: contentId, contentType: contentType));
  }

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids) =>
      loadWithFirebaseIsolate(
        () => loadResponseOrThrow(() => _api.loadExploreContents(ids)),
      );

  @override
  Future<void> requestContent(ContentRequest requestInfo) =>
      loadResponseOrThrow(() => _api.requestContent(requestInfo));

  @override
  Future<ChannelResponse> loadChannelInfo(String contentId) =>
      loadWithFirebaseIsolate(
        () => loadResponseOrThrow(() => _api.loadChannelInfo(contentId)),
      );
}
