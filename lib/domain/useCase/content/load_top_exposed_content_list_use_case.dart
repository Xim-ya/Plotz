import 'package:uppercut_fantube/utilities/index.dart';


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
