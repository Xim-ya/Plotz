import 'dart:math';
import 'package:uppercut_fantube/domain/model/content/explore/explore_content_model.dart';
import 'package:uppercut_fantube/utilities/index.dart';

/** Created By Ximya - 2023.02.12
 *  랜덤하게 10개의 탐색 컨텐츠 리스트를 불러오는 메소드
 *  아래 기능을 단계별로 실행함.
 *
 *  1. 전체 컨텐츠 Id 리스트 호출
 *  2. 호출한 컨텐츠 Id List에서 무작위로 10개의 id 추출
 *  3. 추출한 10개의 아이디에 해당하는 컨텐츠 데이터 호출
 * */

class LoadRandomPagedExploreContentsUseCase
    extends BaseNoParamUseCase<Result<ExploreContentModel>> {
  LoadRandomPagedExploreContentsUseCase(this._repository);

  final ContentRepository _repository;

  @override
  Future<Result<ExploreContentModel>> call() async {
    // 전체 컨텐츠 아이디 리스트 호출
    final List<String> idList = ContentService.to.contentIdInfo.originIdList;

    // 무작위로 10개의 id 리스트 추출
    final List<String> randomIdList = randomIds(idList);

    // 추출한 10개의 아이디에 해당하는 컨텐츠 데이터 호출
    return _repository.loadContainingIdsContents(randomIdList);
  }

  // 무작위로 10개의 id 추출
  List<String> randomIds(List<String> ids) {
    final idList = ids;
    if (ids.length <= 10) {
      idList.shuffle();
      return idList;
    }

    Random random = Random();
    List<String> result = [];

    for (int i = 0; i < 10; i++) {
      int index = random.nextInt(ids.length);
      result.add(ids[index]);
    }

    return result;
  }
}
