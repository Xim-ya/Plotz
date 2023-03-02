import 'package:soon_sak/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin, FirebaseIsolateHelper
    implements ContentDataSource {
  ContentDataSourceImpl(this._api);

  final ContentApi _api;

  @override
  Future<List<String>> loadTotalContentIdList() =>
      loadWithFirebaseIsolate(() => _api.loadTotalContentIdList());

  @override
  Future<List<VideoResponse>> loadVideoInfo(String id) =>
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadVideoInfo(id)));

  @override
  Future<String> requestContentRegistration(
          ContentRegistrationRequest requestData) =>
      loadWithFirebaseIsolate(
          () => _api.requestContentRegistration(requestData));

  @override
  Future<List<CurationContentResponse>> loadInProgressQurationList() =>
      loadWithFirebaseIsolate(() => _api.loadInProgressQurationList());

  @override
  Future<UserResponse> loadCuratorInfo(String contentId) =>
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadCuratorInfo(contentId)));

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids) =>
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadExploreContents(ids)));

  @override
  Future<void> requestContent(ContentRequest requestInfo) =>
      loadResponseOrThrow(() => _api.requestContent(requestInfo));

  @override
  Future<ChannelResponse> loadChannelInfo(String contentId) =>
      loadWithFirebaseIsolate(
          () => loadResponseOrThrow(() => _api.loadChannelInfo(contentId)));
}
