import 'package:soon_sak/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin, FirebaseIsolateHelper
    implements ContentDataSource {
  ContentDataSourceImpl(this._api);

  final ContentApi _api;

  @override
  Future<List<String>> loadTotalContentIdList() =>
      _api.loadTotalContentIdList();

  // () => loadResponseOrThrow(() => _api.loadTotalContentIdList()));

  @override
  Future<List<VideoResponse>> loadVideoInfo(String id) =>
      // loadResponseOrThrow(() => _api.loadVideoInfo(id));
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadVideoInfo(id)));

  @override
  Future<String> requestContentRegistration(ContentRequest requestData) =>
      _api.requestContentRegistration(requestData);

  @override
  Future<List<CurationContentResponse>> loadInProgressQurationList() =>
      loadResponseOrThrow(() => _api.loadInProgressQurationList());

  @override
  Future<UserResponse> loadCuratorInfo(String contentId) =>
      // loadResponseOrThrow(() => _api.loadCuratorInfo(contentId));
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadCuratorInfo(contentId)));

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids) =>
      // loadResponseOrThrow(() => _api.loadExploreContents(ids));
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadExploreContents(ids)));
}
