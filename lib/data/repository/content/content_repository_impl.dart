import 'package:uppercut_fantube/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  // 홈 상단 노출 콘텐츠 리스트 호출
  @override
  Future<Result<List<PosterExposureContent>>> loadTopExposedContent() async {
    try {
      final response = await _contentDataSource.loadTopExposedContentList();
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

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

  // Top10 컨텐츠 리스트 호출
  @override
  Future<Result<List<ContentShell>>> loadTopTenContentList() async {
    try {
      final response = await _contentDataSource.loadTopTenContentList();
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
}
