import 'dart:convert';
import 'dart:developer';
import 'package:soon_sak/data/index.dart';
import 'package:soon_sak/domain/index.dart';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.02.09
 *  홈 스크린 상단에 위치한 배너 컨텐츠 정보를 불러오는 메소드
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

class LoadCachedBannerContentUseCase
    extends BaseNoParamUseCase<Result<BannerModel>> {
  LoadCachedBannerContentUseCase({
    required StaticContentRepository repository,
    required LocalStorageService localStorageService,
    required ContentService contentService,
  })  : _repository = repository,
        _localStorageService = localStorageService,
        _contentService = contentService;

  final StaticContentRepository _repository;
  final LocalStorageService _localStorageService;
  final ContentService _contentService;

  @override
  Future<Result<BannerModel>> call() async {
    final Object? localData =
        await _localStorageService.getData(fieldName: 'banner');
    final String keyResponse = _contentService.bannerKey!;


    /// 조건 (AND)
    /// LocalStorage에 데이터가 존재한다면,
    /// 배너키 데이터가 존재한다면
    /// 최신화된 키라면
    if (localData.hasData &&
        keyResponse.hasData &&
        _isUpdatedKey(jsonText: localData.toString(), givenKey: keyResponse)) {
      return _getBannerModelFromLocal(localData!);
    } else {
      // 조건 : local data가 존재하지 않는다면 or 최신키가 아니라면
      // 실행 :  api 호출
      return _fetchBannerModel();
    }
  }

  // api 호출하여 데이터 반환
  Future<Result<BannerModel>> _fetchBannerModel() async {
    final response = await _repository.loadBannerContentList();
    return response.fold(
      onSuccess: Result.success,
      onFailure: (e) {
        log('=== LoadBannerContentUseCase / api 호출 실패 \n $e');
        return Result.failure(e);
      },
    );
  }

  // LocalStorage로부터 데이터 반환
  Future<Result<BannerModel>> _getBannerModelFromLocal(Object localData) async {
    final json = jsonDecode(localData.toString());
    final response = BannerResponse.fromJson(json);
    final result = BannerModel.fromResponse(response);
    return Result.success(result);
  }

  /// 'key' 값이 최신화 되어 있는지 확인
  bool _isUpdatedKey({required String jsonText, required String givenKey}) {
    try {
      Map<String, dynamic> data = json.decode(jsonText);
      if (data['key'] == givenKey) {
        return true;
      } else {
        return false;
      }
    } catch(e) {
      _localStorageService.deleteData(fieldName: 'banner');
      return false;
    }

  }

  // 로컬 데이터 삭제
  Future<void> deleteLocalData() async {
    await _localStorageService.deleteData(fieldName: 'banner');
  }
}
