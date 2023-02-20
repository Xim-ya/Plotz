import 'dart:convert';
import 'package:flutter_isolate/flutter_isolate.dart';
import 'package:soon_sak/data/mixin/isolate_helper_mixin.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentDataSourceImpl
    with ApiErrorHandlerMixin, IsolateHelperMixin
    implements ContentDataSource {
  ContentDataSourceImpl(this._api);

  final ContentApi _api;

  @override
  Future<List<String>> loadTotalContentIdList() async {
    return loadWithIsolate(() => _api.loadTotalContentIdList());
  }

  @override
  Future<List<VideoResponse>> loadVideoInfo(String id) {
    return loadResponseOrThrow(() => _api.loadVideoInfo(id));
  }

  @override
  Future<String> requestContentRegistration(ContentRequest requestData) =>
      loadResponseOrThrow(() => _api.requestContentRegistration(requestData));

  @override
  Future<List<CurationContentResponse>> loadInProgressQurationList() =>
      loadResponseOrThrow(() => _api.loadInProgressQurationList());

  @override
  Future<UserResponse> loadCuratorInfo(String contentId) =>
      loadResponseOrThrow(() => _api.loadCuratorInfo(contentId));

  @override
  Future<List<ExploreContentResponse>> loadExploreContents(List<String> ids) {
    return loadWithIsolate(
        () => loadResponseOrThrow(() => _api.loadExploreContents(ids)));
  }
}
