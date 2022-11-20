import 'package:uppercut_fantube/domain/base/base_no_param_use_case.dart';
import 'package:uppercut_fantube/domain/model/content/top_exposed_content_list.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository.dart';
import 'package:uppercut_fantube/utilities/result.dart';

/** Created By Ximya - 2022.11.19
 *  홈 스크린 상단 노출 컨텐츠 리스트 호출 UseeCase
 * */

class LoadTopExposedContentListUseCase
    extends BaseNoParamUseCase<Result<List<TopExposedContent>>> {
  LoadTopExposedContentListUseCase(this._repository);

  final ContentRepository _repository;

  @override
  Future<Result<List<TopExposedContent>>> call() async =>
      _repository.loadTopExposedContent();
}
