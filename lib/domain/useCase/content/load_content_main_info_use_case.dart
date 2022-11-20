import 'package:uppercut_fantube/domain/base/base_use_case.dart';
import 'package:uppercut_fantube/domain/model/content/content_main_info.dart';
import 'package:uppercut_fantube/domain/repository/content/content_repository.dart';
import 'package:uppercut_fantube/utilities/result.dart';

/** Created By Ximya - 2022.11.19
 *  - 컨텐츠 상세 페이지[ContentDetailScreen]에서 사용되는 데이터들을 호출하는 [UseCase]
 *  - 전달 받은 인자값에 따라 리턴하는 객체가 다름
 *    -  [ContentMainInfo] -> 헤더 & 컨텐츠 탭
 *    -  [String] -> 정보탭
 * */

class LoadContentMainInfoUseCase
    extends BaseUseCase<String, Result<ContentMainInfo>> {
  LoadContentMainInfoUseCase(this._repository);

  final ContentRepository _repository;

  @override
  Future<Result<ContentMainInfo>> call(String request) =>
      _repository.loadContentMainInfo();
}
