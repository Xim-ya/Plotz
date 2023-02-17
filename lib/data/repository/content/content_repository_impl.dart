import 'package:soon_sak/domain/exception/content/content_exception.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  // 컨텐츠 에피소드 아이템 리스트 호출
  @override
  Future<Result<List<ContentEpisodeInfoItem>>>
      loadContentEpisodeItemList() async {
    try {
      final response = await _contentDataSource.loadContentEpisodeItemList();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<CategoryBaseContentList>>>
      loadContentListWithCategory() async {
    try {
      final response = await _contentDataSource.loadContentWithCategory();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<SimpleContentInfo>>> loadAllOfTvContentList() async {
    try {
      final response = await _contentDataSource.loadAllOfTvContentList();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<SimpleContentInfo>>> loadAllOfMovieContentList() async {
    try {
      final response = await _contentDataSource.loadAllOfMovieContentList();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ContentVideos>> loadDramaContentVideoList(int contentId) async {
    try {
      final response =
          await _contentDataSource.loadDramaContentVideoList(contentId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ContentVideos>> loadMovieContentVideoList(int contentId) async {
    try {
      final response =
          await _contentDataSource.loadMovieContentVideoList(contentId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  // 탐색 컨텐츠 기본(contentId, videoId, type) 정보 호출
  @override
  Future<Result<List<ExploreContent>>>
      loadBasicInfoOfExploreContentList() async {
    try {
      final response = await _contentDataSource.loadExploreContentIdInfoList();
      return Result.success(
          response.map((e) => ExploreContent.fromIdInfoResponse(e)).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

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
  Future<Result<ExploreContentModel>> loadContainingIdsContents(
      List<String> ids) async {
    try {
      final response = await _contentDataSource.loadContainingIdsContents(ids);
      final result = ExploreContentModel.fromResponse(response);
      return Result.success(result);
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
  Future<Result<List<CurationContent>>>
      loadInProgressQurationList() async {
    try {
      final response = await _contentDataSource.loadInProgressQurationList();
      return Result.success(
          response.map(CurationContent.fromResponse).toList());
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
