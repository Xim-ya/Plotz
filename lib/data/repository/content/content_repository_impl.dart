import 'package:soon_sak/domain/model/video/content_video_model.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  @override
  Future<Result<List<ContentIdInfoItem>>> loadContentIdInfoList() async {
    try {
      final response = await _contentDataSource.loadTotalContentIdList();
      return Result.success(
        response.map(ContentIdInfoItem.fromOriginId).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<ExploreContent>>> loadExploreContents(
    List<String> ids,
  ) async {
    try {
      final response = await _contentDataSource.loadExploreContents(ids);
      return Result.success(
        response.map(ExploreContent.fromResponse).toList(),
      );
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> requestContent(ContentRequest requestInfo) async {
    try {
      final response = await _contentDataSource.requestContent(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
