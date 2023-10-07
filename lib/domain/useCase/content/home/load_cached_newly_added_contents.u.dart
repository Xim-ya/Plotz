import 'dart:convert';
import 'dart:developer';

import 'package:soon_sak/data/api/staticContent/response/newly_added_content_response.dart';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/domain/model/content/home/newly_added_content_info.m.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2023.08.14
 *  홈 스크린 위치한 최근 업로드된 컨텐츠 정보를 불러오는 메소드
 *  Local Storage에 배너 컨텐츠 정보가 저장되어 있을 경우 api call을 따로 하지 않고 우회함.
 *  API call 최소화하고 LocalStorage에 접근해 데이터를 빠르게 받기 위함 (캐싱)
 *
 *  상세 로직은 아래와 같음.
 *
 *  1. 로컬 데이터가 존재하고
 *  2. 최신화된 키를 보유하고 있다면
 *  ==> Local에서 데이터 반환
 *
 *  반대의 경우 API Call
 *
 * */

class LoadCachedNewlyAddedContentsUseCase
    extends BaseNoParamUseCase<Result<NewlyAddedContentInfo>> {
  LoadCachedNewlyAddedContentsUseCase({
    required StaticContentRepository repository,
    required LocalStorageService localStorageService,
    required ContentService contentService,
  })  : _repository = repository,
        _localStorageService = localStorageService,
        _contentService = contentService;

  final LocalStorageService _localStorageService;
  final StaticContentRepository _repository;
  final ContentService _contentService;

  @override
  Future<Result<NewlyAddedContentInfo>> call() async {
    // 1. storage 데이터 존재 유무 확인
    final Object? localData = await _localStorageService.getData(
      fieldName: CachedCategoryType.newlyAdded.name,
    );
    final String keyResponse = _contentService.newlyAddedContentKey!;

    /// 조건 (AND)
    /// LocalStorage에 데이터가 존재한다면,
    /// 배너키 데이터가 존재한다면
    /// 최신화된 키라면
    if (localData.hasData &&
        keyResponse.hasData &&
        _isUpdatedKey(
          jsonText: localData.toString(),
          givenKey: keyResponse,
        )) {
      return _getNewlyAddedContentFromLocal(localData!);
    } else {
      // 조건 : local data가 존재하지 않는다면
      // 실행 :  api 호출

      return fetchNewlyAddedContents();
    }
  }

  /// api 호출
  Future<Result<NewlyAddedContentInfo>> fetchNewlyAddedContents() async {
    final response = await _repository.loadNewlyAddedContents();
    return response.fold(
      onSuccess: Result.success,
      onFailure: (e) {
        log('=== LoadCachedNewlyAddedContentUseCase / 2-c) / api 호출 실패 \n $e');
        return Result.failure(e);
      },
    );
  }

  // LocalStorage로부터 데이터 반환
  Future<Result<NewlyAddedContentInfo>> _getNewlyAddedContentFromLocal(
      Object localData) async {
    final json = jsonDecode(localData.toString());
    final response = NewlyAddedContentResponse.fromJson(json);
    final result = NewlyAddedContentInfo.fromResponse(response);
    return Result.success(result);
  }

  /// 'key' 값이 최신화 되어 있는지 확인
  bool _isUpdatedKey({required String jsonText, required String givenKey}) {
    try {
      Map<String, dynamic> data = json.decode(jsonText);
      if (data['key'] == givenKey) {
        print("업데이트 키라고? : ${data['key']} == ${givenKey}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      _localStorageService.deleteData(
          fieldName: CachedCategoryType.newlyAdded.name);
      return false;
    }
  }
}
