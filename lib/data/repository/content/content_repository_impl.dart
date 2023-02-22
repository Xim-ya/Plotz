import 'package:soon_sak/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;


  @override
  Future<Result<List<ContentIdInfoItem>>> loadContentIdInfoList() async {
    try {
      final response = await _contentDataSource.loadTotalContentIdList();
      return Result.success(
          response.map((e) => ContentIdInfoItem.fromOriginId(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }




  @override
  Future<Result<ContentVideos>> loadContentVideoInfo(String id) async {
    try {
      final response = await _contentDataSource.loadVideoInfo(id);
      final result = ContentVideos.fromResponse(response, id: id);
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<String>> requestContentRegistration(
      ContentRequest requestData) async {
    try {
      final response =
      await _contentDataSource.requestContentRegistration(requestData);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(ContentException.qurationRequestFailed());
    }
  }

  @override
  Future<Result<List<CurationContent>>> loadInProgressQurationList() async {
    try {
      final response = await _contentDataSource.loadInProgressQurationList();
      return Result.success(
          response.map(CurationContent.fromResponse).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserModel>> loadCuratorInfo(String contentId) async {
    try {
      final response = await _contentDataSource.loadCuratorInfo(contentId);
      return Result.success(UserModel.fromCurationRes(response));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ExploreContent>>> loadExploreContents(
      List<String> ids) async {
    try {
      final response = await _contentDataSource.loadExploreContents(ids);
      return Result.success(
          response.map((e) => ExploreContent.fromResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
