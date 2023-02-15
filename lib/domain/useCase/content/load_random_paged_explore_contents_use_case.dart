import 'dart:math';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.02.12
 *  랜덤하게 10개의 탐색 컨텐츠 리스트를 불러오는 메소드
 *  아래 기능을 단계별로 실행함.
 *
 *  1. 전체 컨텐츠 Id 리스트 호출
 *  2. 호출한 컨텐츠 Id List에서 무작위로 20개의 id 추출
 *  3. 추출한 20개의 아이디에 해당하는 컨텐츠 데이터 호출
 *
 * */

class LoadRandomPagedExploreContentsUseCase
    extends BaseNoParamUseCase<Result<ExploreContentModel>> {
  LoadRandomPagedExploreContentsUseCase(this._repository, this._service);

  final ContentRepository _repository;
  final ContentService _service;

  bool pagedAllowed = true;
  final List<String> prevIds = [];

  Future<Result<ExploreContentModel>> pagedCall() async {
    //  무작위로 10개 id 추출 (이전 호출한 id 리스트를 제외)
    final List<String> randomIdList = getRandomIdsExceptPrevIds(
        prevIds: prevIds, ids: _service.contentIdInfo!.originIdList);

    pagedAllowed = false;
    return _repository.loadContainingIdsContents(randomIdList);
  }

  @override
  Future<Result<ExploreContentModel>> call() async {
    // 전체 컨텐츠 아이디 리스트 호출
    await _service.prepare();
    final List<String> idList = _service.contentIdInfo!.originIdList;

    // 무작위로 20개의 id 리스트 추출
    final List<String> randomIdList = getRandomIds(idList, 20);
    prevIds.addAll(randomIdList);

    // 추출한 10개의 아이디에 해당하는 컨텐츠 데이터 호출
    return _repository.loadContainingIdsContents(randomIdList);
  }

  /// 무작위로 20개 id 추출 (이전 호출한 id 리스트를 제외)
  /// 이전 호출한 ids 리스트 제외한 ids의 길이가 20 이하라면
  /// 남은 id 리스트 모두 호출
  List<String> getRandomIdsExceptPrevIds(
      {required List<String> prevIds, required List<String> ids}) {
    final filteredIds = ids.toSet().difference(prevIds.toSet()).toList();
    final random = Random();
    List<String> result = [];


    if (filteredIds.length <= 20) {
      for (int i = 0; i < filteredIds.length; i++) {
        int index = random.nextInt(filteredIds.length);
        result.add(filteredIds[index]);
      }
      return result;
    } else {
      for (int i = 0; i < 10; i++) {
        int index = random.nextInt(filteredIds.length);
        result.add(filteredIds[index]);
      }
      return result;
    }
  }


  // 무작위로 id 리스트 추출
  List<String> getRandomIds(List<String> someArray, int count) {
    var arrayCopy = List<String>.from(someArray);
    count = min(count, arrayCopy.length);
    var selectedElements = <String>[];

    var random = Random();
    for (var i = 0; i < count; i++) {
      var randomIndex = random.nextInt(arrayCopy.length);
      selectedElements.add(arrayCopy[randomIndex]);
      arrayCopy.removeAt(randomIndex);
    }

    return selectedElements;
  }
}
