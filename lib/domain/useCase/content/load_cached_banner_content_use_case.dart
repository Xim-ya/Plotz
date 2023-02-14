import 'dart:convert';
import 'dart:developer';
import 'package:soon_sak/utilities/index.dart';

/** Created By Ximya - 2022.02.09
 *  홈 스크린 상단에 위치한 배너 컨텐츠 정보를 불러오는 메소드
 *  Local Storage에 배너 컨텐츠 정보가 저장되어 있을 경우 api call을 따로 하지 않고 우회함.
 *  API call 최소화하고 LocalStorage에 접근해 데이터를 빠르게 받기 위함 (캐싱)
 *
 *  상세 로직은 아래와 같은.
 *
 *  1) Local Storage에 데이터가 저장되어 있는지 확인
 *  2) local 데이터가 있다면 아래 동작을 수행
 *      a) Static content keysData 호출
 *      b) 저장되어 있다면 'key' 값이 최신화 되어 있는지 확인
 *      c) 최신화 되어 있다면 Usecase 데이터 반환
 *      c) 최신화 되어 있지 않다면 api 호출
 *
 *
 *  3) local 데이터가 없다면 api 호출
 *
 * */

class LoadCachedBannerContentUseCase
    extends BaseNoParamUseCase<Result<BannerModel>> {
  LoadCachedBannerContentUseCase(this._repository);

  final StaticContentRepository _repository;

  @override
  Future<Result<BannerModel>> call() async {
    // 1. storage 데이터 존재 유무 확인
    final Object? localData =
        await LocalStorageService.to.getData(fieldName: 'banner');

    // 조건 : local data가 존재한다면
    if (localData.hasData) {
      // 2-a).Static content keysData 호출
      final String? keyResponse = await fetchContentKey();

      // 조건 : 키 값이 정상적으로 받아왔다면
      if (keyResponse.hasData) {
        // 2-b). 'key' 값이 최신화 되어 있는지 확인
        // 조건 : 최신 업데이트 된 키라면
        // 실행 : 2-c) 로컬 데이터로 리턴
        if (isUpdatedKey(
            jsonText: localData.toString(), givenKey: keyResponse!)) {
          final json = jsonDecode(localData.toString());
          final response = BannerResponse.fromJson(json);
          final result = BannerModel.fromResponse(response);
          return Result.success(result);
        }
        // 조건 : 최신 업데이트 키가 아니라면
        // 실행 : 2-c) api 호출
        else {
          return fetchBannerModel();
        }
      }
      // 조건 : 키 값이 정상적으로 불러오지 못했다면
      // 실행 : 2-c) api 호출
      else {
        return fetchBannerModel();
      }
    } else {
      // 조건 : local data가 존재하지 않는다면
      // 실행 :  api 호출
      return fetchBannerModel();
    }
  }

  /// 2-c)
  /// api 호출
  Future<Result<BannerModel>> fetchBannerModel() async {
    final response = await _repository.loadBannerContentList();
    return response.fold(
      onSuccess: Result.success,
      onFailure: (e) {
        log('=== LoadBannerContentUseCase / 2-c) / api 호출 실패 \n $e');
        return Result.failure(e);
      },
    );
  }

  /// 2-a)
  /// Static content keysData 호출
  /// 데이터 호출에 실패한 경우 리턴값이 null
  Future<String?> fetchContentKey() async {
    final response = await _repository.loadStaticContentKeys();
    response.getOrThrow();
    return response.fold(
      onSuccess: (data) {
        return data.bannerKey;
      },
      onFailure: (e) {
        log('====== Static Content Key 호출 실패 $e');
        return null;
      },
    );
  }

  /// 2-b)
  /// 'key' 값이 최신화 되어 있는지 확인
  bool isUpdatedKey({required String jsonText, required String givenKey}) {
    Map<String, dynamic> data = json.decode(jsonText);
    final response = BannerResponse.fromJson(data);

    if (response.key == givenKey) {
      return true;
    } else {
      return false;
    }
  }
}
