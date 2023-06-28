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
 *  Edited By Ximya - 2023.02.22
 *  추가호출 로직추가
 *  기존에 호출한 컨텐츠를 제외한 랜덤 컨텐츠 호출
 *  더 이상 호출할 컨텐츠가 없을 경우 viewModel 레이에서 확인할 수 있도록 State 설정
 * */

class LoadRandomPagedExploreContentsUseCase
    extends BaseNoParamUseCase<Result<List<ExploreContent>>> {
  LoadRandomPagedExploreContentsUseCase(
      {required ContentRepository repository, required ContentService service})
      : _repository = repository,
        _service = service;

  final ContentRepository _repository;
  final ContentService _service;
  bool extraPagedCallAllowed = true;
  final List<String> prevIds = [];

  @override
  Future<Result<List<ExploreContent>>> call() async {
    // 전체 컨텐츠 아이디 리스트 호출
    final List<String> idList = _service.contentIdInfo!.originIdList;

    // 무작위로 20개의 id 리스트 추출
    final List<String> randomIdList = getRandomIds(idList, 20);
    prevIds.addAll(randomIdList);

    // 추출한 아이디에 해당하는 컨텐츠 데이터 호출
    return _repository.loadExploreContents(randomIdList);
  }

  Future<Result<List<ExploreContent>>> loadMoreContents() async {
    /// 아직 호출되지 않은 컨텐츠 id 추출
    /// 전체 컨텐츠 리스트 - 호출된 컨텐츠
    final List<String> waitingCallIds = _service.contentIdInfo!.originIdList
        .where((element) => !prevIds.contains(element))
        .toList();

    // 다음 call에서 더 이상 호출 id가 없다면
    if (waitingCallIds.length < 20) {
      extraPagedCallAllowed = false;
    }

    // 무작위로 20개의 id 리스트 추출
    final List<String> randomIdList =
        getRandomIds(waitingCallIds, waitingCallIds.length);
    prevIds.addAll(randomIdList);

    // 추출한 아이디에 해당하는 컨텐츠 데이터 호출
    return _repository.loadExploreContents(randomIdList);
  }

  /// 무작위로 20개 id 추출 (이전 호출한 id 리스트를 제외)
  /// 이전 호출한 ids 리스트 제외한 ids의 길이가 20 이하라면
  /// 남은 id 리스트 모두 호출
  List<String> getRandomIdsExceptPrevIds({
    required List<String> prevIds,
    required List<String> ids,
  }) {
    final filteredIds = ids.toSet().difference(prevIds.toSet()).toList();
    final random = Random();
    List<String> result = [];

    if (filteredIds.length < 20) {
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
