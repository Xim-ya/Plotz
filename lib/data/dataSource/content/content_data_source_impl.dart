import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin, FirebaseIsolateHelper
    implements ContentDataSource {
  ContentDataSourceImpl(this._api);

  final ContentApi _api;

  @override
  Future<List<String>> loadTotalContentIdList() =>
      loadWithFirebaseIsolate(_api.loadTotalContentIds);

  @override
  Future<List<VideoResponse>> loadVideoInfo(
      {required String contentId, required MediaType contentType}) async {
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
      loadResponseOrThrow(() => _api.createRequestContent(requestInfo));

  @override
  Future<ChannelResponse> loadChannelInfo(String contentId) =>
      loadWithFirebaseIsolate(
        () => loadResponseOrThrow(() => _api.loadChannelInfo(contentId)),
      );

  @override
  Future<bool> checkIfContentAlreadyRequested(String contentId) =>
      loadResponseOrThrow(() => _api.checkIfContentAlreadyRequested(contentId));
}
