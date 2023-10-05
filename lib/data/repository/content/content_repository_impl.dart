import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

class ContentRepositoryImpl implements ContentRepository {
  ContentRepositoryImpl(this._contentDataSource);

  final ContentDataSource _contentDataSource;

  @override
  Future<Result<List<ContentIdInfoItem>>> loadContentIds() async {
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
  Future<Result<void>> createRequestContent(ContentRequest requestInfo) async {
    try {
      final response = await _contentDataSource.requestContent(requestInfo);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkIfContentAlreadyRequested(String contentId) async {
    try {
      final response =
          await _contentDataSource.checkIfContentAlreadyRequested(contentId);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
