import 'dart:convert';
import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.02.09
 *  홈 스크린 위치한 TopTen10 컨텐츠 정보를 불러오는 메소드
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


class LoadCachedTopTenContentsUseCase
    extends BaseNoParamUseCase<Result<TopTenContentsModel>> {
  LoadCachedTopTenContentsUseCase(
    this._repository,
    this._localStorageService,
    this._contentService,
  );

  final LocalStorageService _localStorageService;
  final StaticContentRepository _repository;
  final ContentService _contentService;

  @override
  Future<Result<TopTenContentsModel>> call() async {
    // 1. storage 데이터 존재 유무 확인
    final Object? localData =
        await _localStorageService.getData(fieldName: 'topTen');
    final String keyResponse = _contentService.topTenContentKey!;

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
      return _getTopTenModelFromLocal(localData!);
    } else {
      // 조건 : local data가 존재하지 않는다면
      // 실행 :  api 호출
      return fetchTopTenContent();
    }
  }

  /// api 호출
  Future<Result<TopTenContentsModel>> fetchTopTenContent() async {
    final response = await _repository.loadTopTenContent();
    return response.fold(
      onSuccess: Result.success,
      onFailure: (e) {
        log('=== LoadCachedTopTenContentUseCase / 2-c) / api 호출 실패 \n $e');
        return Result.failure(e);
      },
    );
  }

  // LocalStorage로부터 데이터 반환
  Future<Result<TopTenContentsModel>> _getTopTenModelFromLocal(
      Object localData,) async {
    final json = jsonDecode(localData.toString());
    final response = TopTenContentResponse.fromJson(json);
    final result = TopTenContentsModel.fromResponse(response);
    return Result.success(result);
  }


  /// 'key' 값이 최신화 되어 있는지 확인
  bool _isUpdatedKey({required String jsonText, required String givenKey}) {
    Map<String, dynamic> data = json.decode(jsonText);
    final response = TopTenContentResponse.fromJson(data);

    if (response.key == givenKey) {
      return true;
    } else {
      return false;
    }
  }
}
