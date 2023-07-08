import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/extensions/determine_content_type.dart';
import 'package:soon_sak/utilities/index.dart';

/* Created By Ximya - 2022.12.31
 *  컨텐츠의 유튜브 비도오 정보 리스트를 호출하는 useCase
 *  [contentId] 와[contentType]을 인자로 전달 받음.
 *  [contentType]값('tv' 'movie')에 따라 다른 Api를 호출
* */

class LoadContentVideoInfoUseCase {
  LoadContentVideoInfoUseCase(this._dataSource);

  final ContentDataSource _dataSource;

  Future<Result<ContentVideoModel>> call(
      {required ContentType contentType,
      required String contentId,
      required BuildContext context}) async {
    try {
      final response = await _dataSource.loadVideoInfo(
          contentId: contentId, contentType: contentType);
      ContentVideoModel result;
      if (contentType.isMovie) {
        result = ContentVideoModel.fromMovieResponse(response, context);
      } else {
        result = ContentVideoModel.fromTvResponse(response, context);
      }

      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
